//
//  Constants.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

final class Constants {
    static let shared = Constants()
    private init() {}
}

extension Constants {
    var scrnPercForSlider: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.height * 0.45
        }
    }
    
    var scrnPercForTitle: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.width * 0.7
        }
    }
    
    var scrnPercForSheet: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.height * 0.85
        }
    }
    
    static let mainHorizontalPadding: CGFloat = 30
    static let sheetCornerRadius: CGFloat = 30
    static let paddingBetweenSections: CGFloat = 40
    static let paddingForCloseButton = EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10)
    
    var countries: [CountryElement] {
        if let fileUrl = Bundle.main.url(forResource: "currencies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileUrl)
                return try .init(data: data)
            } catch {
                return []
            }
        } else {
            return []
        }
    }
}

