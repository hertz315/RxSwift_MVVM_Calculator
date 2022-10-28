//
//  UIFont+EXT.swift
//  Dailly_Challenge_CommunityList
//
//  Created by Hertz on 9/25/22.
//

import UIKit

extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var regular: UIFont {return withWeight(.regular)}
    var thin: UIFont {return withWeight(.thin)}
    var heavy: UIFont {return withWeight(.heavy)}
    var medium: UIFont {return withWeight(.medium)}
    var ultraLight: UIFont {return withWeight(.ultraLight)}

    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

