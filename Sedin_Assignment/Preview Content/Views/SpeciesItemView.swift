//
//  SpeciesItemView.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI

struct SpeciesItemView: View {
    
    @ObservedObject var viewModel: SpeciesListViewModel  // inject view model from parent View
    var speciesItem: Species
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text("\(speciesItem.id ?? 0) - ").font(.title2).fontWeight(.bold).foregroundStyle(.primary)
                Text(speciesItem.commonName ?? "").font(.title2).fontWeight(.bold).foregroundStyle(.primary).multilineTextAlignment(.center)
            }
            
            Text("ScientificName: \(speciesItem.scientificName ?? "")").font(.subheadline).fontWeight(.light).foregroundStyle(.secondary)
            
            HStack{
                Label(speciesItem.conservationStatus ?? "", systemImage: "shield.fill").padding(8)
                    .background(viewModel.statusColor(speciesItem.conservationStatus ?? "").opacity(0.2))
                    .foregroundStyle(viewModel.statusColor(speciesItem.conservationStatus ?? "")).cornerRadius(6).font(.headline)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    Text("Group: \(speciesItem.group ?? "")")
                    Text("Status: \(speciesItem.isoCode ?? "")")
                }.font(.caption).foregroundStyle(.purple)
            }
            
        }.padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)).shadow(color: Color.blue.opacity(0.1), radius:16, x: 0, y: 3))
            .padding(.horizontal)
    }
}


