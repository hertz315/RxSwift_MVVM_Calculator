//
//  UILabel+EXT.swift
//  Dailly_Challenge_CommunityList
//
//  Created by Hertz on 9/25/22.
//

import UIKit
// MARK: - UILabel 익스텐션
extension UILabel {
    func numberOfLine() -> Int {
        
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight))
    }
    
}

