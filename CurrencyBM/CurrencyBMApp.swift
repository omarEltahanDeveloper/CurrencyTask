//
//  CurrencyBMApp.swift
//  CurrencyBM
//
//  Created by Omar M1 on 03/06/2023.
//

import SwiftUI

@main
struct CurrencyBMApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
