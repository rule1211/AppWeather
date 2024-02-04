//
//  OpenWeatherResponse.swift
//  WeatherCustomApp
//
//  Created by Stefan Ruzic on 11.7.22..
//

import Foundation

struct OpenWeatherResponse: Codable {
    let main: MainJson
    let weather: [WeatherJson]
    let coord : CoordJson
    let wind : WindJson
    let clouds : CloudsJson
    var base : String
    var visibility : Int
    var dateTime : Date
    var timeZone : Int
    var id : Int
    var name : String
    var cod : Int
    var sys : SunJson
    
    enum CodingKeys : String, CodingKey {
        case main = "main"
        case weather = "weather"
        case coord = "coord"
        case wind = "wind"
        case clouds = "clouds"
        case base = "base"
        case visibility = "visibility"
        case dateTime = "dt"
        case timeZone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
        case sys = "sys"
    }
}
struct MainJson: Codable {
    var current : Double
    var feelsLike: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    
    enum CodingKeys : String, CodingKey {
        case current = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
struct WeatherJson: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}
struct CoordJson: Codable {
    var longitude : Double
    var latitude : Double
    
    enum CodingKeys : String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
struct WindJson: Codable {
    var speed: Double
    var degrees: Double
    
    enum CodingKeys : String, CodingKey {
        case speed = "speed"
        case degrees = "deg"
    }
}
struct CloudsJson: Codable {
    var clouds : Int
    
    enum CodingKeys : String, CodingKey {
        case clouds = "all"
    }
}

struct SunJson: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int


    enum CodingKeys : String, CodingKey {
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"

    }
}

