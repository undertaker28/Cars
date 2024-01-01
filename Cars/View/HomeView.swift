//
//  HomeView.swift
//  Cars
//
//  Created by Pavel on 29.12.23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Car.model, ascending: true)],
        animation: .default)
    private var cars: FetchedResults<Car>
    
    @State private var searchText = ""
    
    var filteredCars: [Car] {
        if searchText.isEmpty {
            return Array(cars)
        } else {
            return cars.filter { car in
                return car.model?.localizedCaseInsensitiveContains(searchText) == true
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 30) {
                        ForEach(filteredCars) { car in
                            NavigationLink(destination: DetailCarView(car: car)) {
                                CarCellView(car: car)
                                    .swipeDeleteCustomModifier {
                                        PersistenceController.shared.deleteCar(car: car, context: managedObjContext)
                                    }
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: CarFormView(carFormViewModel: CarFormViewModel(mode: .add)),
                        label: {
                            Label("Add Car", systemImage: "plus")
                        })
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        PersistenceController.shared.deleteAllCars(context: managedObjContext)
                    } label: {
                        Image(systemName: "arrow.up.trash")
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .background(Color("Background"))
        .accentColor(Color("Element"))
    }
}

#Preview {
    HomeView()
}
