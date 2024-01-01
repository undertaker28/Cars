//
//  SplashView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                Image("Icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
