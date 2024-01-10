//
//  ElementCardPresenter.swift
//  BNETTestTask
//
//  Created by Алексей on 03.05.2023.
//

import Foundation

protocol ElementCardVCProtocol: AnyObject {
    func showElement(element: DrugsModel)
}

protocol ElementCardPresenterProtocol {
    func getElement()
}

final class ElementCardPresenter {
    
    // MARK: - Private properties
    
    private weak var view: ElementCardVCProtocol?
    private let element: DrugsModel
    
    
    // MARK: - Life cycle
    
    init(view:ElementCardVCProtocol, element: DrugsModel) {
        self.view = view
        self.element = element
    }
}


// MARK: - ElementCardPresenterProtocol

extension ElementCardPresenter: ElementCardPresenterProtocol {
    func getElement() {
        view?.showElement(element: element)
    }
}
