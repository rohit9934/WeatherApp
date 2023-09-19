//
//  WeatherInfoView.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 18/09/23.
//

import SwiftUI

struct WeatherInfoView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Image("cloud.sun")
                    .resizable()
                    .frame(width: 25,height: 25)
                    .padding(.bottom)

                Text("Jammu")
                    .font(.title2)
                    .padding(.bottom)
                Text("Today is Cloudy")
                    .bold()
                    .padding(.bottom)
                Text("5° C")
            }.foregroundColor(.white)
        }
            .cornerRadius(50)
            
    }
}

struct WeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoView()
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
