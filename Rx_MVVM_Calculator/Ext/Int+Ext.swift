//
//  Int+EXT.swift
//  Dailly_Challenge_CommunityList
//
//  Created by Hertz on 9/25/22.
//

import UIKit

// MARK: - Int 익스텐션
extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}

