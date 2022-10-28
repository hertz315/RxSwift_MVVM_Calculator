//
//  UIViewController+Ext.swift
//  CustomLoadingBtnTutorial
//
//  Created by Jeff Jeong on 2022/09/14.
//

import Foundation
import UIKit

#if DEBUG
import SwiftUI

extension UIViewController {
    
    private struct VCRepresentable : UIViewControllerRepresentable {
        
        let viewController : UIViewController
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
        
    }
    func getPreview() -> some View {
        VCRepresentable(viewController: self)
    }
}


#endif
