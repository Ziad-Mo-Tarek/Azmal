//
//  AzmalPharmaciesApp.swift
//  AzmalPharmacies
//
//  Created by Ziad Tarek on 10/03/2026.
//

import SwiftUI
import CoreData

@main
struct AzmalPharmaciesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
