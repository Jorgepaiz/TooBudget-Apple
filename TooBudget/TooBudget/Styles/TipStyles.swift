//
//  TipStyles.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/6/24.
//

import SwiftUI
import TipKit

struct InfoTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.title
                    .font(.headline)
                    .fontWeight(.medium)
                    .kerning(2)
                    .foregroundStyle(.tint4)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .foregroundStyle(.tint4.gradient.opacity(1.0))
                        .padding([.top, .trailing], 10)
                }
            }
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.circle")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.tint4.gradient)
                    .padding([.leading, .bottom])
                
                configuration.message
                    .font(.subheadline)
                    .fontWeight(.light)
                    .kerning(1)
                    .foregroundStyle(.shade3)
                    .padding(.bottom)
                
                Spacer()
            }
            HStack {
                ForEach(configuration.actions) { action in
                    Button(action: action.handler) {
                        action.label()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
    }
}

struct SuccessTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.title
                    .font(.headline)
                    .fontWeight(.medium)
                    .kerning(2)
                    .foregroundStyle(.tint4)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .foregroundStyle(.tint4.gradient.opacity(0.9))
                        .padding([.top, .trailing], 10)
                }
            }
            HStack(alignment: .top) {
                Image(systemName: "checkmark.circle")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.tint4.gradient)
                    .padding([.leading, .bottom])
                
                configuration.message
                    .font(.subheadline)
                    .fontWeight(.light)
                    .kerning(1)
                    .foregroundStyle(.shade3)
                    .padding(.bottom)
                
                Spacer()
            }
            HStack {
                ForEach(configuration.actions) { action in
                    Button(action: action.handler) {
                        action.label()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
    }
}

struct WarningTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.title
                    .font(.headline)
                    .fontWeight(.medium)
                    .kerning(2)
                    .foregroundStyle(.tint4)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .foregroundStyle(.tint4.gradient.opacity(0.8))
                        .padding([.top, .trailing], 10)
                }
            }
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.tint4.gradient.opacity(0.9))
                    .padding([.leading, .bottom])
                
                configuration.message
                    .font(.subheadline)
                    .fontWeight(.light)
                    .kerning(1)
                    .foregroundStyle(.shade3)
                    .padding(.bottom)
                
                Spacer()
            }
            HStack {
                ForEach(configuration.actions) { action in
                    Button(action: action.handler) {
                        action.label()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
    }
}

struct ErrorTipStyle: TipViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            HStack {
                configuration.title
                    .font(.headline)
                    .fontWeight(.medium)
                    .kerning(2)
                    .foregroundStyle(.tint4)
                    .padding(.leading)
                
                Spacer()
                
                Button(action: { configuration.tip.invalidate(reason: .tipClosed) }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .foregroundStyle(.tint4.gradient.opacity(0.8))
                        .padding([.top, .trailing], 10)
                }
            }
            HStack(alignment: .top) {
                Image(systemName: "x.circle")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(.tint4.gradient.opacity(0.9))
                    .padding([.leading, .bottom])
                
                configuration.message
                    .font(.subheadline)
                    .fontWeight(.light)
                    .kerning(1)
                    .foregroundStyle(.shade3)
                    .padding(.bottom)
                
                Spacer()
            }
            HStack {
                ForEach(configuration.actions) { action in
                    Button(action: action.handler) {
                        action.label()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
    }
}
