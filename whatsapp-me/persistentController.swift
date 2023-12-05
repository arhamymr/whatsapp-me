//
//  coredataController.swift
//  whatsapp-me
//
//  Created by arham on 03/12/23.
//

import Foundation
import CoreData


class PersistentController: ObservableObject {
    static let shared = PersistentController()
    private let container: NSPersistentContainer
    
    @Published var managedObjectContext: NSManagedObjectContext
    @Published var data : [NumbersEntity]?
    
    init() {
        container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores {
            _, error in
            
            if let error = error {
                fatalError("Error loading Core Data persistent stores: \(error.localizedDescription)")
            }
        }
        
        managedObjectContext = container.viewContext
    }
    
    func saveContext() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            fatalError("error saving core data context: \(error)")
        }
    }
    
    func fetchObjects() {
        let entity = NumbersEntity.self
        let request = NSFetchRequest<NumbersEntity>(entityName: String(describing: entity))
        
        do {
            data = try managedObjectContext.fetch(request)
        } catch {
            fatalError("Failed to fetch data")
        }
    }
    
    func createObject<T:NSManagedObject>(entity: T.Type) -> T {
        return NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: managedObjectContext) as! T
    }
}
