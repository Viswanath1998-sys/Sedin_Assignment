//
//  CircularLoader.swift
//  Sedin_Assignment
//
//  Created by Viswanath M on 15/06/25.
//

import SwiftUI


struct CircularLoader: View {
    
    @State private var trimEnd = 0.6
    @State private var animate = false
    
    var body: some View {
        Circle()
            .trim(from: 0.0,to: trimEnd)
            .stroke(.blue, style: StrokeStyle(lineWidth: 7,lineCap: .round,lineJoin:.round))
            .animation(
                Animation.easeIn(duration: 1)
                    .repeatForever(autoreverses: true),
                value: trimEnd
            )
            .frame(width: 50,height: 50)
            .rotationEffect(Angle(degrees: animate ? 270 + 360 : 270))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear{
                animate = true
                trimEnd = 0
            }
    }
}
