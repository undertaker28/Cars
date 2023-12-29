//
//  CarFormViewModel.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import CoreData
import SwiftUI

enum CarFormMode {
    case add
    case edit(Car)
}

final class CarFormViewModel: ObservableObject {
    var mode: CarFormMode
    
    @Published var model: String = ""
    @Published var producer: String = ""
    @Published var selectedDate: Date = Date.now
    @Published var color: Color = Color.black
    @Published var selectedImage: UIImage?
    @Published var isImagePickerPresented = false
    
    init(mode: CarFormMode) {
        self.mode = mode
        setupInitialValues()
    }
    
    private func setupInitialValues() {
        switch mode {
        case let .edit(car):
            model = car.model ?? "None"
            producer = car.producer ?? "None"
            
            let components = DateComponents(year: Int(car.year ?? "2000"))
            selectedDate = Calendar.current.date(from: components)!
            
            do {
                let decoder = JSONDecoder()
                color = try decoder.decode(Color.self, from: car.colorData ?? Data())
            } catch {
                color = .cyan
            }
            
            selectedImage = UIImage(data: car.picture ?? Data()) ?? UIImage()
        default:
            break
        }
    }
    
    func saveCar(context: NSManagedObjectContext) {
        let encoder = JSONEncoder()
        var colorData = Data()
        do {
            colorData = try encoder.encode(color)
        } catch {
            print("Error encoding color: \(error)")
        }
        
        switch mode {
        case .add:
            PersistenceController.shared.addCar(model: model, producer: producer, year: selectedDate.get(.year), picture: selectedImage?.pngData() ?? Data(), colorName: UIColor(color).accessibilityName.capitalized, colorData: colorData, context: context)
        case let .edit(car):
            PersistenceController.shared.updateCar(car: car, model: model, producer: producer, year: selectedDate.get(.year), picture: selectedImage?.pngData() ?? Data(), colorName: UIColor(color).accessibilityName.capitalized, colorData: colorData, context: context)
        }
    }
}
