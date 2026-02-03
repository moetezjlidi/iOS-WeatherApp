//
//  WeatherDisplay.swift
//  MyWeatherApp
//
//  Created by Master IDL on 20/01/2026.
//

import SwiftUI

struct WeatherDisplay: View {
    let city: City
    
    var body: some View {
       HStack(alignment: .center) {
           
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
           
           Text(city.name)
               .font(.system(size: 24, weight: .bold))


           Spacer()

           VStack(alignment: .trailing, spacing: 4) {
               if let temperature = city.temperature {
                   Text("\(temperature)°C")
                       .font(.system(size: 24, weight: .bold))
               }
               
               Text(city.weather ?? "—")
                   .font(.system(size: 18))

           }
       }
       .padding()
       .background(
           RoundedRectangle(cornerRadius: 12)
               .stroke(Color.accentColor, lineWidth: 4)
       )
       .cornerRadius(12)
    }
    
}

#Preview {
    WeatherDisplay(city: City(
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

