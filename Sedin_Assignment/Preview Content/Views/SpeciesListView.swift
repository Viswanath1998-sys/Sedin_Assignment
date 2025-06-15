//
//  SpeciesListView.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//


import SwiftUI

struct SpeciesListView: View {
    
    @StateObject private var viewModel = SpeciesListViewModel()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue.opacity(0.4), .white.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack{
                handleCurrentViewStatus()
            }
            
        }.navigationTitle("Species")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss() // Back to previous View
                    } label: {
                        HStack{
                            Image(systemName: "arrow.left").resizable().aspectRatio(contentMode: .fit).frame(width: 20, height: 20)
                            Text("Back").font(.headline).foregroundStyle(Color.blue)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search for Species")
            .task {
                // call APi/ catched data when view appears
                await viewModel.handleSpeciesListFetch(isConnected: networkMonitor.isConnected)
            }
        
            .alert("Error", isPresented: $viewModel.showError) { // show alert when API call throws error
                Button("Ok", role: .cancel) { viewModel.showError = false }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error occured")
            }
    }
    

    // handle View state conditions
    @ViewBuilder
    private func handleCurrentViewStatus() -> some View{
        switch viewModel.viewState {
        case .loading:
            CircularLoader()
        case .dataEmpty:
            VStack(spacing: 20){
                EmptyStateView(emptyMessage: "No Species found.")
                Button {
                    Task{
                        await viewModel.handleSpeciesListFetch(isConnected: networkMonitor.isConnected)
                    }
                } label: {
                    Text("Retry").padding().font(.headline).foregroundStyle(.white).background(Capsule(style: .circular))
                }
            }
        case .searchEmpty:
            EmptyStateView(emptyMessage: "No matches found for your seach.")
        case .hasData:
            ScrollView{
                LazyVStack{
                    ForEach(viewModel.filteredSpeciesList, id: \.id){ speciesItem in
                        SpeciesItemView(viewModel: viewModel, speciesItem: speciesItem)
                    }
                }
            }
        }
    }
}

#Preview {
    SpeciesListView()
}




