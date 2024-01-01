//
//  CarCellView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct CarCellView: View {
    @ObservedObject var car: Car
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(car.producer ?? "None")
                        .font(.system(size: 30, weight: .bold, design: .monospaced))
                    Text("\(car.model ?? "None") (\(car.year ?? ""))")
                        .font(.system(size: 26, weight: .bold, design: .monospaced))
                }
                .padding()
                
                Spacer()
                
                NavigationLink {
                    CarFormView(carFormViewModel: CarFormViewModel(mode: .edit(car)))
                } label: {
                    Image(systemName: "pencil")
                        .font(.system(size: 15, weight: .bold))
                        .padding(8)
                        .background(Color("Background"))
                        .clipShape(Circle())
                }
                .padding()
            }
            .padding(.bottom, 5)
            
            CarImageView(uiImage: UIImage(data: car.picture ?? Data()))
                .padding()
                .frame(width: 340, height: 200)
                .offset(y: -5)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 290)
        .foregroundColor(Color("Element"))
        .background(.purple)
        .cornerRadius(30)
        .padding(.horizontal, 20)
    }
}
