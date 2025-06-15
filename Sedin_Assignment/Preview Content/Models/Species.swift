//
//  Species.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import Foundation


struct Species: Codable, Identifiable{
    let id : Int?
    let commonName : String?
    let scientificName : String?
    let conservationStatus : String?
    let group : String?
    let isoCode : String?
   
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case conservationStatus = "conservation_status"
        case group = "group"
        case isoCode = "iso_code"
    
    }
    
    func filterSearchText(searchText: String) -> Bool {
        // search filter with Case insensitive
        let lowerCasedSearchText = searchText.lowercased()
        return scientificName?.lowercased().contains(lowerCasedSearchText) ?? false || commonName?.lowercased().contains(lowerCasedSearchText) ?? false || group?.lowercased().contains(lowerCasedSearchText) ?? false || isoCode?.lowercased().contains(lowerCasedSearchText) ?? false || conservationStatus?.lowercased().contains(lowerCasedSearchText) ?? false || String(describing: id ?? 0).contains(searchText)
    }
}
