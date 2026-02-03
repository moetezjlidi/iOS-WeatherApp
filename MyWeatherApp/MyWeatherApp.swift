//
//  MyWeatherAppApp.swift
//  MyWeatherApp
//
//  Created by Master IDL on 20/01/2026.
//

import SwiftUI
import SwiftData
@main
struct MyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .modelContainer(for: City.self)
        }
        
    }
}
