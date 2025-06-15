//
//  CoreDataStack.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import CoreData
import SwiftUI



class CoreDataStack{
    
    static let shared = CoreDataStack()
    let container: NSPersistentContainer
    
    init(){
        container =  NSPersistentContainer(name: "Sedin_Assignment")
        container.loadPersistentStores { description, error in
            if let error = error  {
                fatalError("Loading Core Data error \(error)")
            }
        }
    }
    
    var context:NSManagedObjectContext{
        container.viewContext
    }
    
    var backgroundContext:NSManagedObjectContext{
        container.newBackgroundContext()
    }
    
    func saveContext(){
        
        let context = container.viewContext
        
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("Saving context failed with error \(error)")
            }
        }
    }
}


