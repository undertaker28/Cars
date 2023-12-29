//
//  PersistenceController.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Car")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            context.rollback()
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func addCar(model: String, producer: String, year: Int, picture: Data, colorName: String, colorData: Data, context: NSManagedObjectContext) {
        let car = Car(context: context)
        
        car.id = UUID()
        car.model = model
        car.producer = producer
        car.year = String(year)
        car.picture = picture
        car.colorName = colorName
        car.colorData = colorData
        
        save(context: context)
    }
    
    func updateCar(car: Car, model: String, producer: String, year: Int, picture: Data, colorName: String, colorData: Data, context: NSManagedObjectContext) {
        car.model = model
        car.producer = producer
        car.year = String(year)
        car.picture = picture
        car.colorName = colorName
        car.colorData = colorData
        
        save(context: context)
    }
    
    func deleteCar(car: Car, context: NSManagedObjectContext) {
        context.delete(car)
        
        save(context: context)
    }
    
    func deleteAllCars(context: NSManagedObjectContext) {
        let fetchRequest = Car.fetchRequest()
        let cars = try? context.fetch(fetchRequest)
        
        for car in cars ?? [] {
            context.delete(car)
        }
        
        save(context: context)
    }
}
