//
//  City.swift
//  MyWeatherApp
//
//  Created by Master IDL on 20/01/2026.
//
import SwiftData
import Foundation
@Model
class City {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String?
    var temperature: Int?
    var weather: String?
    var desc: String?
    var speed: Double?
    var lon: Double?
    var lat: Double?

    init(
        name: String,
        icon: String?,
        temperature: Int?,
        weather: String?,
        desc: String?,
        speed: Double?,
        lon: Double?,
        lat: Double?
    ) {
        self.id = UUID()
        self.name = name
        self.icon = icon
        self.temperature=temperature
        self.weather = weather
        self.desc = desc
        self.speed = speed
        self.lon = lon
        self.lat = lat
    }
}
