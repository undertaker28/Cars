//
//  YearPicker.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct YearPicker: View {
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack {
            Text("Year")
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .frame(width: 20)
                .onTapGesture {
                    selectedDate = Calendar.current.date(byAdding: .year, value: -1, to: selectedDate) ?? Date.now
                }
            
            Text(String(selectedDate.get(.year)))
                .fontWeight(.bold)
                .transition(.move(edge: .trailing))
            
            Image(systemName: "chevron.right")
                .frame(width: 20)
                .onTapGesture {
                    selectedDate = Calendar.current.date(byAdding: .year, value: 1, to: selectedDate) ?? Date.now
                }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(Color("Element"))
        .background(Color("Purple"))
        .cornerRadius(15)
    }
}
