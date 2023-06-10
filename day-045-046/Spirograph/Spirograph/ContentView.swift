//
//  ContentView.swift
//  Spirograph
//
//  Created by nfls on 10/06/2023.
//

import SwiftUI


struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    let step: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount

        var path = Path()

        for theta in stride(from: 0, through: endPoint, by: step) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)

            x += rect.width / 2
            y += rect.height / 2

            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        return path
    }
    
}

struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    @State private var step = 0.01
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Spacer()

                Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount, step: step)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                    .frame(width: 300, height: 300)
                    .drawingGroup()

                Spacer()

                Group {
                    Text("Inner radius: \(Int(innerRadius))")
                    Slider(value: $innerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Outer radius: \(Int(outerRadius))")
                    Slider(value: $outerRadius, in: 10...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Text("Distance: \(Int(distance))")
                    Slider(value: $distance, in: 1...150, step: 1)
                        .padding([.horizontal, .bottom])

                    Group {
                        Text("Step: \(step)")
                        Slider(value: $step, in: 0.02...2, step: 0.01)
                            .padding([.horizontal, .bottom])
                    }

                    Group {
                        Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                        Slider(value: $amount)
                            .padding([.horizontal, .bottom])
                    }

                    Text("Color")
                    Slider(value: $hue)
                        .padding(.horizontal)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
