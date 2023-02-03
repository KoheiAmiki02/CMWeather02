//
//  ContentViewModel.swift
//  CMWeather02
//
//  Created by cmStudent on 2023/02/02.
//

import Foundation

import Combine
class ContentViewModel: ObservableObject {
    @Published var oneCall: OneCall?
    @Published var forecast: Forecast?
    let area = ["東京", "埼玉", "千葉", "神奈川", "群馬", "栃木", "茨城"]
    let latlng = [[35.68944,139.69167], [35.85694,139.64889], [35.60472,140.12333], [35.44778,139.6425], [36.39111,139.06083], [36.56583,139.88361], [36.34139,140.44667]]
    @Published var city: String = "東京"
    var currentTemp: String = ""
    var currentWeatherDescription: String = ""
    var dailyTempMin: String = ""
    var dailyTempMax: String = ""
    var rainyPercent: String = ""
    let apikey = "c3387b6d241313b8d686d2b77de02810"
    var url: String = ""
    var cancellable = Set<AnyCancellable>()
    
    init() {
        update()
    }
    
    func update() {
        oneCallUpdate()
        forecastUpdate()
    }
    
    func oneCallUpdate() {
        let manager = GetOneCall()
        let firstIndex = area.firstIndex(of: city)!

        url = makeUrl(callAPI: "onecall", latlng: latlng[firstIndex], apikey: apikey)
        let publisher = manager.getOneCall(url: url)

        publisher?.sink(receiveCompletion: { _ in
            print("onecall finished")
        }, receiveValue: { [self] oneCall in
            print("testo")
            self.oneCall = oneCall
            self.currentTemp = roundValue(value: self.oneCall!.current.temp)
            self.currentWeatherDescription = self.oneCall!.current.weather[0].weatherDescription
            self.dailyTempMin = roundValue(value: self.oneCall!.daily[0].temp.min)
            self.dailyTempMax = roundValue(value: self.oneCall!.daily[0].temp.max)
        })
        .store(in: &cancellable)
    }
    
    func forecastUpdate() {
        let manager = GetForecast()
        let firstIndex = area.firstIndex(of: city)!

        url = makeUrl(callAPI: "forecast", latlng: latlng[firstIndex], apikey: apikey)
        let publisher = manager.getForecast(url: url)
        
        publisher?.sink(receiveCompletion: { completion in
            switch completion {
                
            case .finished:
                print("finished")
            case .failure(let error):
                print(error)
                
            }
            print("forecast finished")
        }, receiveValue: { [self] forecast in
            print("testf")
            self.forecast = forecast
            self.rainyPercent = changePercent(num: self.forecast!.list[0].pop)
        })
        .store(in: &cancellable)
    }
    // url生成
    private func makeUrl(callAPI: String, latlng: [Double], apikey: String) -> String {
        var url = "https://api.openweathermap.org/data/2.5/"
        url.append(callAPI)
        url.append("?lat=")
        url.append(String(latlng[0]))
        url.append("&lon=")
        url.append(String(latlng[1]))
        url.append("&lang=ja&exclude=minutely,alerts&units=metric&appid=")
        url.append(apikey)
        return url
    }
    
    // DoubleをStringに変換
    private func roundValue(value: Double) -> String {
        return String(Int(round(value)))
    }
    
    private func changePercent(num: Double) -> String {
        print(num)
        return String(Int(round(num * 100)))
    }
}




