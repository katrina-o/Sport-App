//
//  UIView+Ext.swift
//  Sport App
//
//  Created by Екатерина Орлова on 18.03.2025.
//

import UIKit
//
//extension UIView {
//    static func addSubviews(_ views: UIView...) {
//        views.forEach { addSubview($0) }
//    }
//}
extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
