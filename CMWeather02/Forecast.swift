//
//  Forecast.swift
//  CMWeather02
//
//  Created by cmStudent on 2023/02/02.
//

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let list: [List]
}

// MARK: - List
struct List: Codable {
    let pop: Double
}
