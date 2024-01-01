//
//  CarImageView.swift
//  Cars
//
//  Created by Pavel on 30.12.23.
//

import SwiftUI

struct CarImageView: View {
    let uiImage: UIImage?
    
    var body: some View {
        Image(uiImage: uiImage ?? UIImage(named: "NoImage")!)
            .resizable()
            .scaledToFit()
            .cornerRadius(7)
    }
}
