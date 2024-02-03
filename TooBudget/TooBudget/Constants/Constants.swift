//
//  Constants.swift
//  TooBudget
//
//  Created by Jorge Paiz on 2/2/24.
//

import SwiftUI

final class Constants {
    // screen percentages
    static var scrnPercForSlider: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.height * 0.45
        }
    }
    
    static var scrnPercForTitle: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.width * 0.7
        }
    }
    
    static var scrnPercForSheet: (GeometryProxy) -> CGFloat {
        { geometry in
            geometry.size.height * 0.85
        }
    }
    
    static let mainHorizontalPadding: CGFloat = 30
    static let sheetCornerRadius: CGFloat = 30
    static let paddingBetweenSections: CGFloat = 40
    static let paddingForCloseButton = EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10)
}

