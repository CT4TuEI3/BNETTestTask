//
//  MainPresenter.swift
//  BNETTestTask
//
//  Created by Алексей on 02.05.2023.
//

import Foundation

protocol MainViewControllerProtocol: AnyObject {
    func showDrgsList(list: [DrugsModel])
    func stopUpdating()
}

protocol MainPresenterProtocol {
    func getData(offset: Int)
}

final class MainPresenter {
    
    //MARK: - Private properties
    
    private weak var view: MainViewControllerProtocol?
    private let service: NetworkServiceProtocol
    private var lastId: Int?
    
    
    // MARK: - Life cycle
    
    init(view: MainViewControllerProtocol, service: NetworkServiceProtocol) {
        self.view = view
        self.service = service
    }
}


// MARK: - MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {
    func getData(offset: Int) {
        service.getDrugsList(offset: offset, limit: 20, completion: {[weak self] response in
            if response.last?.id != self?.lastId {
                self?.view?.showDrgsList(list: response)
            } else {
                self?.view?.stopUpdating()
            }
            self?.lastId = response.last?.id
        })
    }
}
