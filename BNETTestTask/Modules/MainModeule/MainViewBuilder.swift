//
//  MainViewBuilder.swift
//  BNETTestTask
//
//  Created by Алексей on 02.05.2023.
//

import UIKit

final class MainViewBuilder {
    static func createMainViewModule() -> UIViewController {
        let view = MainViewController()
        let service = NetworkService()
        let presenter = MainPresenter(view: view, service: service)
        view.presenter = presenter
        return view
    }
}
