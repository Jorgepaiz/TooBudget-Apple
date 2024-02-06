//
//  Tips.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/5/24.
//

import Foundation
import TipKit



struct SetFavoriteTip: Tip {
//    static let setFavoriteEvent = Event(id: "setFavorite")
//    static let colorsViewVisitedEvent = Event(id: "colorsViewVisited")
    
    var title: Text {
        Text("Set Favorites")
            .font(.headline)
            .fontWeight(.regular)
            .kerning(2)
            .foregroundStyle(.tint4)
    }
    
    var message: Text? {
        Text("Tap and hold a color to add it to your favorites")
            .font(.subheadline)
            .fontWeight(.light)
            .kerning(1)
            .foregroundStyle(.shade3)
    }
    
//    var rules: [Rule] {
//        #Rule(Self.setFavoriteEvent) { event in
//            event.donations.count == 0
//        }
//        
//        #Rule(Self.colorsViewVisitedEvent) { event in
//            event.donations.count > 2
//        }
//    }
}
