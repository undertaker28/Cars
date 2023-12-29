//
//  DetailCarView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct DetailCarView: View {
    @Environment(\.dismiss) var dismiss
    
    var car: Car
    
    var body: some View {
        ZStack {
            Color("Purple")
                .ignoresSafeArea()
            
            Color("Background")
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .padding(.top, 360)
                .ignoresSafeArea()
            
            VStack {
                Text(car.model ?? "None")
                    .font(.title)
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                
                if let image = UIImage(data: car.picture ?? Data()) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                } else {
                    Image("NoImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 200)
                }
            }
            .foregroundColor(Color("Element"))
            .offset(y: -240)
            
            VStack {
                Text("INFORMATION")
                    .font(.system(size: 28, weight: .bold, design: .monospaced))
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading, spacing: 6) {
                    infoRow(firstText: "Producer:", secondText: car.producer ?? "None", fontSize: 24, colorForFirstText: Color("LightPurple"))
                    
                    infoRow(firstText: "Year:", secondText: car.year ?? "2000", fontSize: 24, colorForFirstText: Color("LightPurple"))
                    
                    infoRow(firstText: "Color:", secondText: car.colorName ?? "Black", fontSize: 24, colorForFirstText: Color("LightPurple"))
                }
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundColor(Color("Element"))
            .offset(y: -10)
        }
    }
}
