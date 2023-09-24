//
//  AdditionalInfoView.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 21/09/23.
//

import SwiftUI

struct AdditionalInfoView: View {
    @Binding var weatherInfo: BasicWeatherInfoDataModel
    var body: some View {
        HStack {
                VStack(spacing: 10) {
                    Text("\(weatherInfo.humidity) %")
                        .font(.system(size: 20))
                        .bold()
                    Text("Humidity")
                    
                }
                .foregroundColor(.white)
                .padding(.leading)
                Spacer()
                VStack(spacing: 10) {
                    Text("\(weatherInfo.visibility / 1000) km")
                        .font(.system(size: 20))
                        .bold()
                    Text("Visibility")
                }
                .foregroundColor(.white)
                
                Spacer()
                VStack(spacing: 10) {
                    Text(String(format: "%.2f km/h", weatherInfo.wind_speed))
                        .font(.system(size: 20))
                        .bold()
                    Text("Wind Speed")
                    
                }
                .foregroundColor(.white)
                
                    .padding(.trailing)
        }
        .frame(height: 100)
    }
}


//struct AdditionalInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdditionalInfoView(weatherInfo: BasicWeatherInfoDataModel())
//            .previewLayout(.fixed(width: UIScreen.screenWidth - 40, height: 100))
//    }
//}
