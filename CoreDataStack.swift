//
//  CoreDataStack.swift
//  SedinAssignment
//
//  Created by Viswanath M on 13/06/25.
//

import CoreData
import SwiftUI



class CoreDataStack{
    
    static let shared = CoreDataStack()
    let container: NSPersistentContainer
    
    init(){
        container =  NSPersistentContainer(name: "SedinAssignment")
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


