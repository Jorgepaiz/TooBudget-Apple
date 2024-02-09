//
//  ActivityIndicatorView.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/4/24.
//

import SwiftUI

struct ActivityIndicator: View {
    @State private var positions: [CGPoint] = Array(repeating: .zero, count: 10)
    @State private var rotations: [Double] = Array(repeating: 0, count: 10)
    var message: String = ""
    
    let symbols: [SymbolData] = [
        SymbolData(name: "chart.bar", color: .random, rotationSpeed: 2, reverse: false),
        SymbolData(name: "chart.pie", color: .random, rotationSpeed: 3, reverse: true),
        SymbolData(name: "creditcard", color: .random, rotationSpeed: 4, reverse: false),
        SymbolData(name: "dollarsign.circle", color: .random, rotationSpeed: 5, reverse: true),
        SymbolData(name: "wallet.pass", color: .random, rotationSpeed: 6, reverse: false),
        SymbolData(name: "folder", color: .random, rotationSpeed: 7, reverse: true),
        SymbolData(name: "signature", color: .random, rotationSpeed: 8, reverse: false),
    ]
    
    struct SymbolData {
        let name: String
        let color: Color
        let rotationSpeed: Double
        let reverse: Bool
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<symbols.count, id: \.self) { index in
                    Image(systemName: symbols[index].name)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(symbols[index].color)
                        .position(positions[index])
                        .rotationEffect(.degrees(symbols[index].reverse ? -rotations[index] : rotations[index]))
                        .onAppear {
                            withAnimation(Animation.linear(duration: symbols[index].rotationSpeed).repeatForever(autoreverses: false)) {
                                rotations[index] = 360
                            }
                            withAnimation(Animation.easeInOut(duration: Double.random(in: 3...6)).repeatForever(autoreverses: true)) {
                                positions[index] = CGPoint(x: CGFloat.random(in: 0...300), y: CGFloat.random(in: 0...600))
                            }
                        }
                }
                
                Text(LocalizedStringKey(message))
                    .foregroundStyle(.shade4)
                    .kerning(3)
                Text(LocalizedStringKey(message))
                    .foregroundStyle(.tint2)
                    .offset(x: 1, y: -1)
                    .kerning(3)
            }
            .font(.system(size: 22, weight: .semibold, design: .monospaced))
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding()
        }
        .presentationBackground(.shade4.opacity(0.75))
    }
}

#Preview {
    ActivityIndicator()
}

fileprivate extension Color {
    
    static var random: Color {
        var colors: [Color] = [.tint1, .tint2, .tint3, .tint4, .triadic1, .triadic2, .tetradic1, .tetradic2, .tetradic3, .analogous1, .analogous2, .complementary, .trueTetradic1, .trueTetradic2, .trueTetradic3]
        var usedColors: Set<Color> = []
        
        // the color array was emptied, so reload
        if colors.isEmpty {
            colors = Array(usedColors)
            usedColors.removeAll()
        }
        guard let selectcolor = colors.randomElement() else { return principal }
        usedColors.insert(selectcolor)
        colors.removeAll { $0 == selectcolor }
        return selectcolor.opacity(0.75)
    }
}

