import SwiftUI
import SwiftData

struct AddCity: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State private var cityName: String = ""
    let apiId : String = "c27baf976fb40bb27b2b0fea6b55928a"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Ajouter une ville")
                .font(.title2)
                .bold()
            
            HStack {
                TextField("Ex : Marseille", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Valider") {
                    let now = Date().timeIntervalSince1970
                    let oneMinute: TimeInterval = 60
                    let apiURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiId)&units=metric")!
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

                                let city = City(
                                    name: cityName,
                                    icon: decoded.weather.first?.icon,
                                    temperature: Int(decoded.main.temp.rounded()),
                                    weather: decoded.weather.first?.main,
                                    desc: decoded.weather.first?.description,
                                    speed: decoded.wind.speed,
                                    lon: decoded.coord.lon,
                                    lat: decoded.coord.lat
                                )

                                context.insert(city)
                                try? context.save()
                                dismiss()

                            } catch {
                                print("Decoding error:", error)
                            }
                        }

                    }.resume()
    
                }
                .disabled(cityName.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(cityName.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray.opacity(0.5) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Button("Annuler") {
                dismiss()
            }
            .foregroundColor(.red)
        }
        .padding()
        .frame(width: 320) 
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(UIColor.systemBackground)))
        .shadow(radius: 10)
    }
}
