//
//  ContentView.swift
//  Flower
//
//  Created by nfls on 09/06/2023.
//

import SwiftUI

struct Flower: Shape {
    
    var petalOffset: Double
    var petalWidth: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for angle in stride(from: 0, to: Double.pi * 2, by: Double.pi / 16) {
            let rotation = CGAffineTransform(rotationAngle: angle)
            let transform = rotation.concatenating(
                CGAffineTransform(translationX: rect.midX, y: rect.midY))
            
            var petal = Path()
            petal.addEllipse(in: CGRect(x: petalOffset,
                                        y: 0,
                                        width: petalWidth,
                                        height: rect.height / 2))
            path.addPath(petal.applying(transform))
        }
        
        return path
    }
}

struct BetterSlider: View {
    
    @Binding var value: Double
    let minValue: Double
    let maxValue: Double
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Slider(value: $value, in: minValue...maxValue)
        }
    }
}

struct ContentView: View {
    
    @State var petalOffset = 0.0
    @State var petalWidth = 10.0
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack {
                
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    //.stroke([.red, .blue, .green, .yellow].randomElement() ?? .white, lineWidth: 1)
                    .fill([.red, .blue, .green, .yellow].randomElement() ?? .white, style: FillStyle.init(eoFill: true, antialiased: true))
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.width * 0.8)

                VStack {
                    Divider()
                        .padding(.bottom)
                    BetterSlider(value: $petalOffset, minValue: -40, maxValue: 40, title: "Petal Offset")
                    
                    BetterSlider(value: $petalWidth, minValue: -150, maxValue: 150, title: "Petal Width")
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
