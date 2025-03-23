//
//  SportFactory.swift
//  Sport App
//
//  Created by Екатерина Орлова on 20.03.2025.
//

import UIKit

final class SportFactory {
    static func makeSportModule() -> UIViewController {
        let presenter = SportPresenter()
        let viewController = SportViewController(presenter: presenter)
        presenter.setupView(viewController)
        return viewController
    }
}
