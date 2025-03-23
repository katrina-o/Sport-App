//
//  UILabel+Ext.swift
//  Sport App
//
//  Created by Екатерина Орлова on 18.03.2025.
//
import UIKit

extension UILabel {
    static  func makeCustomLabel( font: UIFont, textColor: UIColor, numberOfLines: Int? = 0, textAligment: NSTextAlignment? = .center) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = textColor
        label.numberOfLines = numberOfLines ?? 0
        label.textAlignment = textAligment ?? .center
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

