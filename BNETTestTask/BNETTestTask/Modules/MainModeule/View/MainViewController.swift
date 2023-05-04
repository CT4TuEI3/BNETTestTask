//
//  MainViewController.swift
//  BNETTestTask
//
//  Created by Алексей on 27.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    
    // MARK: - Private propertyes
    
    private let cardCellIdentifire = "cardCellIdentifire"
    private var drugsData: [DrugsModel] = []
    private var filtredData: [DrugsModel] = []
    private var isNeedUpdate = true

    
    // MARK: - UI elements
    
    private let mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let customNavBarView = UIView()
    private let searchController = UISearchController()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getData(offset: 0)
        setupUI()
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = Colors.globalWhite
        view.addSubview(mainCollectionView)
        view.addSubview(customNavBarView)
        settingNavBar()
        settingsCollectionView()
        settingsSearchBar()
        setConstraints()
    }
    
    private func settingNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        customNavBarView.backgroundColor = Colors.globalLightGreen
        navigationController?.navigationBar.barTintColor = Colors.globalLightGreen
    }
    
    private func settingsCollectionView() {
        mainCollectionView.backgroundColor = Colors.globalWhite
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: cardCellIdentifire)
    }
    
    private func settingsSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setConstraints() {
        customNavBarView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBarView.bottomAnchor.constraint(equalTo: mainCollectionView.topAnchor),
            
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    func stopUpdating() {
        isNeedUpdate = false
    }
    func showDrgsList(list: [DrugsModel]) {
        drugsData.append(contentsOf: list)
        filtredData = drugsData
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
}


// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filtredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ElementViewBuilder.createElementCardModule(element: filtredData[indexPath.row]), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCellIdentifire,
                                                      for: indexPath) as? CardCollectionCell
        cell?.configure(model: filtredData[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == filtredData.count - 6 && isNeedUpdate {
            presenter?.getData(offset: filtredData.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 24, height: 296)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 16, bottom: 15, right: 16)
    }
}


// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredData = []
        if searchText == "" {
            filtredData = drugsData
            self.mainCollectionView.reloadData()
        }
        for word in drugsData {
            if word.name!.lowercased().contains(searchText.lowercased()) {
                filtredData.append(word)
            }
        }
        self.mainCollectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filtredData = drugsData
        mainCollectionView.reloadData()
    }
}
