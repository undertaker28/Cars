//
//  CarFormView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

struct CarFormView: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    @Environment(\.dismiss) private var dismiss
    
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
            CarImageView(uiImage: carFormViewModel.selectedImage)
                .padding(.top, 20)
                .padding(.bottom, 15)
            
            VStack(alignment: .center, spacing: 26) {
                CustomTextField(placeHolder: "Name of model", text: $carFormViewModel.model)
                
                CustomTextField(placeHolder: "Name of producer", text: $carFormViewModel.producer)
                
                YearPicker(selectedDate: $carFormViewModel.selectedDate)
                
                ColorPicker("Color", selection: $carFormViewModel.color)
                    .padding()
                    .fontWeight(.bold)
                    .background(.purple)
                    .cornerRadius(15)
                
                Button("Select Image") {
                    carFormViewModel.isImagePickerPresented = true
                }
                .padding()
                .background(.purple)
                .cornerRadius(10)
                .fontWeight(.bold)
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
                    }
                }
            }
            .foregroundColor(Color("Element"))
        }
        .interactiveDismissDisabled()
        .background(Color("Background"))
    }
}
