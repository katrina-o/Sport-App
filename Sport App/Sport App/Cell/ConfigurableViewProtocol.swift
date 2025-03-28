//
//  ConfigurableViewProtocol.swift
//  Sport App
//
//  Created by Екатерина Орлова on 20.03.2025.
//

import Foundation

protocol ConfigurableViewProtocol {
    associatedtype ConfigurableModel
    func configure(with model: ConfigurableModel)
}
