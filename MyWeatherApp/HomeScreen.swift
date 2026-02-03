import SwiftUI
import SwiftData

struct HomeScreen: View {

    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var popupAddCity = false
    @Query var cities: [City]
    @AppStorage("last_update") private var lastUpdate: Double = 0
    let apiId : String = "c27baf976fb40bb27b2b0fea6b55928a"

    var body: some View {
        NavigationStack {
            Group {
                if cities.isEmpty {
                    EmptyView()
                } else {
                    List {
                        ForEach(cities) { city in
                            NavigationLink {
                                DisplayCity(city: city)
                            } label: {
                                WeatherDisplay(city: city)
                            }
                            
                        }
                        .onDelete(perform: deleteCities)
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        popupAddCity = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("MyWeatherApp")
            .popover(isPresented: $popupAddCity, arrowEdge: .top) {
                AddCity()
            }
            .refreshable {
                await refreshAllCities()
            }
        }
    }
    
    private func refreshAllCities() async{
        let now = Date().timeIntervalSince1970
        let oneMinute: TimeInterval = 60
        
        guard now - lastUpdate > oneMinute else {
            print("Synchronisation ignorée : moins d’une minute depuis la dernière.")
            return
        }
        
        lastUpdate = Date().timeIntervalSince1970
        
        for city in cities {
            
            let apiURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.name)&appid=\(apiId)&units=metric")!
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let config = URLSessionConfiguration.default
            config.allowsCellularAccess = false
            config.httpAdditionalHeaders = ["Accept": "application/json"]
            
            let session = URLSession(configuration: config)
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data else { return }

                DispatchQueue.main.async {
                    do {
                        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

                        city.icon = decoded.weather.first?.icon
                        city.temperature = Int(decoded.main.temp.rounded())
                        city.weather = decoded.weather.first?.main
                        city.desc = decoded.weather.first?.description
                        city.speed = decoded.wind.speed
                        city.lon = decoded.coord.lon
                        city.lat = decoded.coord.lat
                    

                        try? context.save()
                        dismiss()

                    } catch {
                        print("Decoding error:", error)
                    }
                }

            }.resume()
        }
    }
    
    private func deleteCities(at offsets: IndexSet) {
        offsets.forEach { index in
            let city = cities[index]
            context.delete(city)
            
            do {
                try context.save()
                print("Deleted cities successfully")
            } catch {
                print("Failed to delete cities:", error)
            }
        }
    }
}

#Preview {
    HomeScreen()
        .modelContainer(for: City.self)
}
