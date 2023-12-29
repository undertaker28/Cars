//
//  CustomTextField.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct CustomTextField: View {
    let placeHolder: String
    @Binding var text: String
    
    @State private var width = CGFloat.zero
    @State private var labelWidth = CGFloat.zero
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .foregroundColor(Color("Element"))
                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 60))
                .overlay {
                    GeometryReader { geo in
                        Color.clear.onAppear {
                            width = geo.size.width
                        }
                    }
                }
        }
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0, to: 0.55)
                    .stroke(Color("Element"), lineWidth: 1)
                
                RoundedRectangle(cornerRadius: 5)
                    .trim(from: 0.565 + (0.44 * (labelWidth / width)), to: 1)
                    .stroke(Color("Element"), lineWidth: 1)
                
                Text(placeHolder)
                    .foregroundColor(Color("Element"))
                    .overlay {
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                labelWidth = geo.size.width
                            }
                        }
                    }
                    .padding(.leading, 6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(x: 16, y: -11)
            }
        }
    }
}
