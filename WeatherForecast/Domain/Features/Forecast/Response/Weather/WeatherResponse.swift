//
//  WeatherResponse.swift
//  WeatherForecast
//
//  Created by User on 14/06/2022.
//

import Foundation

enum WeatherCondition: String {
    case thunderstorm = "Thunderstorm", drizzle = "Drizzle", rain = "Rain", snow = "Snow", mist = "Mist", smoke = "Smoke", haze = "Haze", dust = "Dust", fog = "Fog", sand = "Sand", ash = "Ash", squall = "Squall", tornado = "Tornado", clear = "Clear", clouds = "Clouds"
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
        case "drizzle": self = .drizzle
        case "rain": self = .rain
        case "snow": self = .snow
        case "mist": self = .mist
        case "smoke": self = .smoke
        case "haze": self = .haze
        case "dust": self = .dust
        case "fog": self = .fog
        case "sand": self = .sand
        case "ash": self = .ash
        case "squall": self = .squall
        case "tornado": self = .tornado
        case "clear": self = .clear
        case "clouds": self = .clouds
        default: self = .thunderstorm
        }
    }
}

struct WeatherResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, main, desc = "description", icon, iconURL
    }
    
    let id: Double?
    let main: WeatherCondition?
    let desc: String?
    let icon: String?
    var iconURL: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decodeIfPresent(Double.self, forKey: .id)
        
        let rawValue = try values.decodeIfPresent(String.self, forKey: .main) ?? ""
        self.main = WeatherCondition(rawValue: rawValue)
        
        self.desc = try values.decodeIfPresent(String.self, forKey: .desc)
        self.icon = try values.decodeIfPresent(String.self, forKey: .icon)
        
        if let icon = icon {
            self.iconURL = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        }
    }
}

extension WeatherResponse {
    func toInfo() -> WeatherInfo {
        return WeatherInfo(id: id ?? 0,
                           main: main ?? .clear,
                           desc: desc ?? "",
                           icon: icon ?? "",
                           iconURL: iconURL ?? "")
    }
}
