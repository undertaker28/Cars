//
//  View+Ex.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CustomCornerShape(radius: radius, corners: corners))
    }
    
    func swipeDeleteCustomModifier(action: @escaping () -> Void) -> some View {
        self.modifier(CarCellDragGestureView(action: action))
    }
    
    func infoRow(firstText: String, secondText: String, fontSize: CGFloat, colorForFirstText: Color) -> some View {
        HStack {
            Text(firstText)
                .font(.system(size: fontSize))
                .foregroundColor(colorForFirstText)
            
            Text(secondText)
                .font(.system(size: fontSize))
        }
    }
}
