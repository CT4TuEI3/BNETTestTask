//
//  ElementViewBuilder.swift
//  BNETTestTask
//
//  Created by Алексей on 03.05.2023.
//

import UIKit

final class ElementViewBuilder {
    static func createElementCardModule(element: DrugsModel) -> UIViewController {
        let view = ElementCardVC()
        let presenter = ElementCardPresenter(view: view, element: element)
        view.presenter = presenter
        return view
    }
}
