import SwiftUI
import SwiftData

struct DisplayCity: View {
    let city: City
    
    var body: some View {
        VStack(spacing: 16) {
  
            Text(city.name)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .shadow(radius: 2)

            HStack(alignment: .center, spacing: 16) {
                
                
                if let iconCode = city.icon {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(city.weather ?? "—")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                    
                    if let desc = city.desc {
                        Text(desc)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))
                            .shadow(radius: 1)
                    }
                }
            }
     
            if let temperature = city.temperature {
                Text("\(temperature)°C")
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 2)
            }
          
            HStack(spacing: 20) {
                if let speed = city.speed {
                    InfoBlock(icon: "wind", label: "\(speed, default: "%.1f") m/s")
                }
                
                if let lat = city.lat, let lon = city.lon {
                    InfoBlock(icon: "location", label: "\(lat, default: "%.2f"), \(lon, default: "%.2f")")
                }
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(
            LinearGradient(
                gradient: Gradient(colors: gradientForWeather(city.weather)),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
    private func gradientForWeather(_ weather: String?) -> [Color] {
        switch weather?.lowercased() {
        case "sunny":
            return [Color.yellow, Color.orange]
        case "cloudy":
            return [Color.gray.opacity(0.7), Color.blue.opacity(0.5)]
        case "rainy":
            return [Color.blue.opacity(0.7), Color.gray.opacity(0.5)]
        case "snow":
            return [Color.white.opacity(0.9), Color.blue.opacity(0.5)]
        default:
            return [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]
        }
    }
}

struct InfoBlock: View {
    let icon: String
    let label: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(.white)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(6)
        .background(Color.black.opacity(0.25))
        .cornerRadius(8)
    }
}

#Preview {
    DisplayCity(city: City(
        name: "Marseille",
        icon: "01d",
        temperature: 15,
        weather: "Sunny",
        desc: "Clear sky",
        speed: 1.65,
        lon: 5.37,
        lat: 43.3
    ))
}

