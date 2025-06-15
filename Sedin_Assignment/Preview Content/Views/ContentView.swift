//
//  ContentView.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI


struct ContentView: View {
    
    @State private var isNavigatetoSpeciesList:Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(colors: [Color.blue.opacity(0.4), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
                VStack(spacing: 16){
                    Text("Welcome to Assignment").font(.headline)
                    
                    Button {
                        isNavigatetoSpeciesList = true
                    } label: {
                        Text("Go to Species List").padding().foregroundStyle(.white).background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                    }
                    
                }
            }.navigationDestination(isPresented: $isNavigatetoSpeciesList) {
                SpeciesListView()
            }
        }
    }
}
#Preview {
    ContentView()
}

