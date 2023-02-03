//
//  GetOneCall.swift
//  CMWeather02
//
//  Created by cmStudent on 2023/02/02.
//

import Foundation
import Combine

class GetOneCall {
    func getOneCall(url: String) -> (AnyPublisher<OneCall, Error>?) {
        
        guard let url = URL(string: url) else { return nil}
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let response = response as? HTTPURLResponse,
                      (200...399).contains(response.statusCode) else {
                    fatalError()
                }
                return data
            }
            .decode(type: OneCall.self, decoder: JSONDecoder())
            .map {
                $0
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
