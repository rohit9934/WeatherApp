//
//  ContentView.swift
//  LearnSwiftUI
//
//  Created by Rohit Sharma on 28/03/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    var body: some View {
        VStack {
           WeatherInfoView()
                .frame(width: UIScreen.screenWidth - 30,height: 300,alignment: .center)
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
