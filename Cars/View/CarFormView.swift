//
//  CarFormView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct CarFormView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject private var carFormViewModel: CarFormViewModel
    
    init(carFormViewModel: CarFormViewModel) {
        self.carFormViewModel = carFormViewModel
    }
    
    private var title: String {
        switch carFormViewModel.mode {
        case .add:
            return "Add Car"
        case .edit:
            return "Edit Car"
        }
    }
    
    var body: some View {
        VStack {
            if let image = carFormViewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(7)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
            } else {
                Image("NoImage")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(7)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
            }
            
            VStack(alignment: .center, spacing: 26) {
                CustomTextField(placeHolder: "Name of model car", text: $carFormViewModel.model)
                
                CustomTextField(placeHolder: "Name of producer car", text: $carFormViewModel.producer)
                
                YearPicker(selectedDate: $carFormViewModel.selectedDate)
                
                ColorPicker("Color", selection: $carFormViewModel.color)
                    .padding()
                    .fontWeight(.bold)
                    .foregroundColor(Color("Element"))
                    .background(.purple)
                    .cornerRadius(15)
                
                Button("Select Image") {
                    carFormViewModel.isImagePickerPresented = true
                }
                .padding()
                .background(.purple)
                .cornerRadius(10)
                .fontWeight(.bold)
                .foregroundColor(Color("Element"))
                .sheet(isPresented: $carFormViewModel.isImagePickerPresented) {
                    ImagePicker(selectedImage: $carFormViewModel.selectedImage)
                }
                
                Button(action: {
                    carFormViewModel.saveCar(context: managedObjContext)
                    dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
                .font(.headline)
                .foregroundColor(Color("Element"))
                .padding()
                .background(.green)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text(title)
                            .bold()
                            .foregroundColor(Color("Element"))
                    }
                }
            }
        }
        .interactiveDismissDisabled()
        .background(Color("Background"))
    }
}
