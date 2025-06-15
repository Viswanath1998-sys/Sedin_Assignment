//
//  SpeciesStorageManager.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import CoreData


class SpeciesStorageManager{
    
    static let shared = SpeciesStorageManager()
    private let context = CoreDataStack.shared.context
    
    
    func saveSpecies(speciesList: [Species]){
        
        deleteAllSpecies() // Delete all before save
        
        for speciesItem in speciesList{
            let entity = SpeciesEntity(context: context)
            
            entity.id = Int64(speciesItem.id ?? 0)
            entity.commonName = speciesItem.commonName ?? ""
            entity.scientificName = speciesItem.scientificName ?? ""
            entity.conservationStatus = speciesItem.conservationStatus ?? ""
            entity.isoCode = speciesItem.isoCode ?? ""
            entity.group = speciesItem.group ?? ""
        }
        
        CoreDataStack.shared.saveContext()
        print("Species list successfully saved in  core data")
    }
    
    func fetchAllSpecies() -> [Species]{
        
        let fetchRequest: NSFetchRequest<SpeciesEntity> = SpeciesEntity.fetchRequest()
        do{
            let entities = try context.fetch(fetchRequest)
            return entities.map{
                Species(id: Int($0.id), commonName: $0.commonName, scientificName: $0.scientificName, conservationStatus: $0.conservationStatus, group: $0.group, isoCode: $0.isoCode)
            }
        }catch{
            print("Error fetching species")
            return []
        }
        
    }
    
    func deleteAllSpecies(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SpeciesEntity")
        let batchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do{
            try context.execute(batchRequest)
            print("successfully deleted all species")
        }catch{
            print("Error deleting All Species")
        }
    }
}
