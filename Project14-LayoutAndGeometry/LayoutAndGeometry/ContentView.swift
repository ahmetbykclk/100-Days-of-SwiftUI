//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Ahmet Büyükçelik on 30.08.2025.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let minY = proxy.frame(in: .global).minY
                        let screenHeight = UIScreen.main.bounds.height
                        
                        let opacity = minY < 200 ? max(0, (minY - 50) / 150) : 1.0
                        
                        let scale = max(0.5, minY / screenHeight)
                        
                        let hue = min(1.0, max(0, (minY / screenHeight) * 0.8))
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: hue, saturation: 0.8, brightness: 0.8))
                            .opacity(opacity)
                            .scaleEffect(scale)
                            .rotation3DEffect(.degrees(minY - screenHeight / 2) / 5, axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(height: 40)
                }
            }
        }
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}
