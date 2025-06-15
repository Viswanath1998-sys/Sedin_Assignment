//
//  SpeciesListViewModel.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import Foundation
import SwiftUI
import Combine
import Network

@MainActor
class SpeciesListViewModel: ObservableObject{
    
    @Published var searchText:String = ""
    @Published var speciesList: [Species] = []
    @Published var isLoading: Bool = false
    @Published var filteredSpeciesList:[Species] = []
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    let networkManager = NetworkManager.shared
    let speciesStorageManager = SpeciesStorageManager.shared
    

    // To cancel the current running subscriber
    private var cancellable: Set<AnyCancellable> = []
    
    
    // computedProperty to handle views current status
    var viewState: ViewCurrentState {
        if isLoading{
            return .loading
        }else if speciesList.isEmpty{
            return .dataEmpty
        }else if filteredSpeciesList.isEmpty{
            return .searchEmpty
        }else {
            return .hasData
        }
    }
    
    
    
    init(){
        print("View Model initialized")
        // fitler Species result while searching
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
        //            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterSearchResultsSpecies(searchText: text)
            }
            .store(in: &cancellable)
    }
    
    
    func performOnAppear(){
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        // fetch Species list from Coredata if internet not connected
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.speciesList = self.speciesStorageManager.fetchAllSpecies()
            self.filterSearchResultsSpecies(searchText: self.searchText)
            self.isLoading = false
            self.errorMessage = "No internet connection. Please check your internet connection and try again."
            self.showError = true
        }
    }
    
    func handleSpeciesListFetch(isConnected: Bool) async{
        if isConnected{
            Task{
                await getSpeciesList()
            }
        }else{
            performOnAppear()
        }
    }
    
    
    func getSpeciesList() async{
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        await networkManager.callSpeciesListAPI { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let speciesListResponse):
                if !(speciesListResponse.isEmpty){
                    DispatchQueue.main.async {
                        self.speciesList = speciesListResponse
                        self.filterSearchResultsSpecies(searchText: self.searchText)
                    }
                    // save Api response to CoreData
                    self.speciesStorageManager.saveSpecies(speciesList: speciesListResponse)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }
            
            DispatchQueue.main.async{
                self.isLoading = false
            }
        }
    }
    
        
    func filterSearchResultsSpecies(searchText: String){
        if searchText.isEmpty{
            self.filteredSpeciesList = self.speciesList
        }else {
            // filter searchText matched list
            self.filteredSpeciesList = speciesList.filter({$0.filterSearchText(searchText: searchText)})
        }
    }
    
    // Species item text and status backgorund color
    func statusColor(_ status: String) -> Color {
        switch status{
        case "CR": return .blue
        case "EN": return .brown
        case "VU": return .red
        case "EX": return .green
        case "NT": return .yellow
        case "LC": return .orange
        case "EW": return .purple
        default: return .gray
        }
    }
}




