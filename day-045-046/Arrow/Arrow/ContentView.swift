//
//  ContentView.swift
//  Arrow
//
//  Created by nfls on 10/06/2023.
//

import SwiftUI

struct TopArrow: Shape {
    private let mult = 5.0
    func path(in rect: CGRect) -> Path {
        let startPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let endPoint = CGPoint(x: rect.midX, y: rect.minY)
        
        var path = Path()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.addLine(to: CGPoint(x: endPoint.x - rect.width / mult / 2,
                                 y: endPoint.y + rect.height / mult))
        
        path.move(to: endPoint)
        path.addLine(to: CGPoint(x: endPoint.x + rect.width / mult / 2,
                                 y: endPoint.y + rect.height / mult))
        
        return path
    }
}

struct CurveRightArrow: Shape {
    private let mult = 5.0
    func path(in rect: CGRect) -> Path {
        let startPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        var path = Path()
        path.move(to: startPoint)
        path.addCurve(to: endPoint,
                      control1: CGPoint(x: rect.midX, y: rect.midY),
                      control2: CGPoint(x: rect.midX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: endPoint.x - rect.height / mult, y: endPoint.y + rect.width / mult / 2))
        
        path.move(to: endPoint)
        path.addLine(to: CGPoint(x: endPoint.x - rect.height / mult, y: endPoint.y - rect.width / mult / 2))
        
        return path
    }
}

struct MovingArrow: Shape {
    
    private let mult = 5.0
    let angle: Double
    
    func path(in rect: CGRect) -> Path {
        
        let transform = rotatedTransform(radians: angle, axis: CGPoint(x: rect.midX, y: rect.midY))
        let startPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let topPoint = CGPoint(x: rect.midX, y: rect.minY)
            .applying(transform)

        let leftPoint = CGPoint(x: rect.midX - rect.width / mult / 2, y: rect.minY + rect.height / mult)
            .applying(transform)
        
        let rightPoint = CGPoint(x: rect.midX + rect.width / mult / 2, y: rect.minY + rect.height / mult)
            .applying(transform)
         
        var path = Path()
        path.move(to: startPoint)
        path.addCurve(to: topPoint,
                      control1: CGPoint(x: rect.midX, y: rect.midY),
                      control2: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: leftPoint)
        
        path.move(to: topPoint)
        path.addLine(to: rightPoint)
        
        return path
    }
    
    private func rotatedTransform(radians: Double, axis: CGPoint) -> CGAffineTransform {
        return CGAffineTransform(translationX: axis.x, y: axis.y)
            .rotated(by: radians)
            .translatedBy(x: -axis.x, y: -axis.y)
    }
    
}

struct ColorCyclingRectangle: View {
    var amount: Double
    var steps: Int

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    
    @State var thickness = 1.0
    @State var movingArrowAngle = 0.0
    @State var amount = 100.0
    @State var steps = 100.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                VStack {
                    HStack(alignment: .center) {
                        MovingArrow(angle: movingArrowAngle)
                            .stroke(.red, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                        
                        TopArrow()
                            .stroke(.red, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                        
                        CurveRightArrow()
                            .stroke(.red, style: StrokeStyle(lineWidth: thickness, lineCap: .round, lineJoin: .round))
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                    }
                    ColorCyclingRectangle(amount: amount, steps: Int(steps))
                        .padding(.top)
                        .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
                }
                .padding()
                
                Text("Line Width: \(thickness)")
                    .font(.headline)
                Slider(value: $thickness, in: 1.0...26.0)
                
                Text("Moving Arrow Angle: \(movingArrowAngle)")
                    .font(.headline)
                Slider(value: $movingArrowAngle, in: -Double.pi/2...Double.pi/2)
                
                Text("Ractangle steps: \(steps)")
                    .font(.headline)
                Slider(value: $steps, in: 1...1000)
                
                Text("Ractangle amount: \(amount)")
                    .font(.headline)
                Slider(value: $amount, in: 1...1000)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
