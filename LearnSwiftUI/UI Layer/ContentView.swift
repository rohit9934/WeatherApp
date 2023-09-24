//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 28/03/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    let height = -1 * UIScreen.screenHeight
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .edgesIgnoringSafeArea(.all)
            HStack {
                VStack {
                    Text(weatherViewModel.weatherInfo.city)
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .offset(x: -30)
                     //   .padding()
                    Text("\(Int(weatherViewModel.weatherInfo.temperature.rounded(.up)))°")
                        .font(.system(size: 100))
        
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 30,y:70)
                .foregroundColor(.white)
                Text(weatherViewModel.weatherInfo.conditon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                    .rotationEffect(.degrees(270))
                    .offset(x: 30, y: -250)
            }
            
            VStack {
                Spacer()
                AdditionalInfoView(weatherInfo: $weatherViewModel.weatherInfo)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white, lineWidth: 2)
                        )
                    .frame(width: UIScreen.screenWidth - 40)
                    .opacity(0.7)
                    .offset(y: -100)
                    
                    
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
