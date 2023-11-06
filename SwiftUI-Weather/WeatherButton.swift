//
//  WeatherButton.swift
//  SwiftUI-Weather
//
//  Created by Tevin Jones on 11/5/23.
//

import Foundation
import SwiftUI

struct WeatherButton: View {
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button("Change Day/Night") {
            action()
        }
           
        
        .frame(width:300, height:50)
        .foregroundStyle(textColor)
        .background(backgroundColor.gradient)
        .font(.system(size: 20, weight: .bold))
        .cornerRadius(10.0)
    }
}
