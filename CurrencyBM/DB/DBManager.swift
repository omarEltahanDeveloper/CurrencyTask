//
//  DBManager.swift
//  CurrencyBM
//
//  Created by Omar M1 on 10/06/2023.
//

import Foundation
import CoreData
import SwiftUI


struct DBManager {
    let viewContext : NSManagedObjectContext
    init() {
        self.viewContext = PersistenceController.shared.container.viewContext
    }
   
    func saveItemToDB(from: String, to: String) {
        let newItem = Currencies(context: self.viewContext)
        newItem.datestamp = Date().getTodayDate()
        newItem.frombase = from
        newItem.tosource = to
        newItem.uniqid = UUID()
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    func checkExistance(from: String, to: String) {
        let fetchRequest: NSFetchRequest<Currencies> = Currencies.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Currencies.datestamp, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "frombase == %@ AND tosource == %@ AND datestamp == %@", from, to, Date().getTodayDate())
        
        do {
            let items = try viewContext.fetch(fetchRequest)
            if items.count == 0 {
                saveItemToDB(from: from, to: to)
            }
        } catch {
            print("Error fetching items: \(error)")
        }
    }
    
    func fetchAllRelatedToDate(date: String) -> [Currencies] {
        let fetchRequest: NSFetchRequest<Currencies> = Currencies.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Currencies.datestamp, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "datestamp == %@", date)
        
        do {
            let items = try viewContext.fetch(fetchRequest)
            return items
        } catch {
            print("Error fetching items: \(error)")
            return []
        }
    }
    
    
}
