//
//  CarsApp.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI

@main
struct CarsApp: App {
    private let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
