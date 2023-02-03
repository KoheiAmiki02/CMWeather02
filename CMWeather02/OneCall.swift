//
//  OneCall.swift
//  CMWeather02
//
//  Created by cmStudent on 2023/02/02.
//

import Foundation

// MARK: - OneCall
struct OneCall: Codable {
    let current: Current
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case current, daily
    }
}

// MARK: - Current
struct Current: Codable {
    let temp: Double
    let weather: [Weather]
}


// MARK: - Daily
struct Daily: Codable {
    let temp: Temp
    let weather: [Weather]
}

// MARK: - Temp
struct Temp: Codable {
    let min, max: Double
}

// MARK: - Weather
struct Weather: Codable {
    let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
    }
}


