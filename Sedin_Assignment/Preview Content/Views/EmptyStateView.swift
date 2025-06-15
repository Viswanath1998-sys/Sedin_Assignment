//
//  EmptyStateView.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI

struct EmptyStateView: View {
    
    var emptyMessage: String
    
    var body: some View {
        VStack(spacing: 16){
            
            Image(systemName: "leaf.arrow.circlepath").font(.system(size: 60)).foregroundStyle(.green)
            
            Text(emptyMessage).font(.headline).foregroundStyle(.primary)
        }
    }
}

#Preview {
    EmptyStateView(emptyMessage: "")
}
