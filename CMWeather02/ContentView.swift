//
//  ContentView.swift
//  CMWeather02
//
//  Created by cmStudent on 2023/02/02.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var contentViewModel = ContentViewModel()
    var body: some View {
        VStack {
            Spacer()
            Text(contentViewModel.city)
                .font(.system(size: 64))
            Text("\(contentViewModel.currentTemp)°")
                .font(.system(size: 48))
            Text(contentViewModel.currentWeatherDescription)
                .font(.system(size: 48))
            HStack {
                Text("最高：\(contentViewModel.dailyTempMax)°")
                    .font(.system(size: 32))
                Text("最低：\(contentViewModel.dailyTempMin)°")
                    .font(.system(size: 32))
            }
            Text("降水確率 \(contentViewModel.rainyPercent)%")
                .font(.system(size: 32))
            Spacer()
            Menu {
                Picker(selection: $contentViewModel.city, label: Text("地域")) {
                    ForEach(contentViewModel.area, id: \.self) { item in
                        Text(item)
                        
                    }
                }
            } label: {
                Text(contentViewModel.city)
                    .font(.system(size: 32))
                    .foregroundColor(Color.black)
                    .frame(width: 250, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 5)
                    )
            }
            Spacer()
        }
        .onChange(of: contentViewModel.city) { _ in
            contentViewModel.update()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
 coord
 lon 経度
 lat 緯度
 main
 temp 温度
 */
