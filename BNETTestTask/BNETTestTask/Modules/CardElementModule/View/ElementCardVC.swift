//
//  ElementCardVC.swift
//  BNETTestTask
//
//  Created by Алексей on 29.04.2023.
//

import UIKit

final class ElementCardVC: UIViewController {
    
    // MARK: - Private propertyes
    
    private var oneElementData: DrugsModel?
    var presenter: ElementCardPresenterProtocol?
    
    
    // MARK: - UI Elements
    
    private let imageOneElement = UIImageView()
    private let iconElement = UIImageView()
    private let titleElementLabel = UILabel()
    private let discriptionElementLabel = UILabel()
    private let addFavoriteButton = UIButton()
    private let whereBuyButton = UIButton()
    private let customNavBarView = UIView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getElement()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = Colors.globalWhite
        view.addSubview(imageOneElement)
        view.addSubview(iconElement)
        view.addSubview(titleElementLabel)
        view.addSubview(discriptionElementLabel)
        view.addSubview(whereBuyButton)
        view.addSubview(addFavoriteButton)
        view.addSubview(customNavBarView)
        customNavBarView.backgroundColor = Colors.globalLightGreen
        navigationController?.navigationBar.tintColor = Colors.globalWhite
        settingsButtons()
        settingsLabels()
        setConstraits()
    }
    
    private func settingsLabels() {
        titleElementLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        titleElementLabel.numberOfLines = 0
        titleElementLabel.lineBreakMode = .byWordWrapping
        
        discriptionElementLabel.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        discriptionElementLabel.textColor = Colors.globalLightGray
        discriptionElementLabel.numberOfLines = 0
        discriptionElementLabel.lineBreakMode = .byWordWrapping
    }
    
    private func settingsButtons() {
        whereBuyButton.backgroundColor = Colors.globalWhite
        let vectorImage = UIImage(systemName: "mappin.circle.fill")?.withTintColor(Colors.globalLightGreen,
                                                                                   renderingMode: .alwaysOriginal)
        whereBuyButton.setImage(vectorImage, for: .normal)
        whereBuyButton.setTitle(" Где купить?", for: .normal)
        whereBuyButton.setTitleColor(Colors.globalBlack, for: .normal)
        whereBuyButton.layer.cornerRadius = 8
        whereBuyButton.layer.borderWidth = 1
        whereBuyButton.layer.borderColor = Colors.globalBorderColor.cgColor
        let starImage = UIImage(systemName: "star")?.withTintColor(Colors.globalLightGray,
                                                                   renderingMode: .alwaysOriginal)
        var configuration = UIButton.Configuration.borderless()
        configuration.image = starImage
        configuration.imagePadding = 0
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        addFavoriteButton.configuration = configuration
    }
    
    private func setConstraits() {
        imageOneElement.translatesAutoresizingMaskIntoConstraints = false
        iconElement.translatesAutoresizingMaskIntoConstraints = false
        titleElementLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionElementLabel.translatesAutoresizingMaskIntoConstraints = false
        whereBuyButton.translatesAutoresizingMaskIntoConstraints = false
        addFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        customNavBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNavBarView.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageOneElement.heightAnchor.constraint(equalToConstant: 215),
            imageOneElement.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageOneElement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 127),
            imageOneElement.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -131),
            
            iconElement.heightAnchor.constraint(equalToConstant: 32),
            iconElement.widthAnchor.constraint(equalToConstant: 32),
            iconElement.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            iconElement.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            addFavoriteButton.heightAnchor.constraint(equalToConstant: 34),
            addFavoriteButton.widthAnchor.constraint(equalToConstant: 34),
            addFavoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 42),
            addFavoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            
            titleElementLabel.topAnchor.constraint(equalTo: imageOneElement.bottomAnchor, constant: 32),
            titleElementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            titleElementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -181),
            
            discriptionElementLabel.topAnchor.constraint(equalTo: titleElementLabel.bottomAnchor, constant: 8),
            discriptionElementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            discriptionElementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            
            whereBuyButton.heightAnchor.constraint(equalToConstant: 36),
            whereBuyButton.topAnchor.constraint(equalTo: discriptionElementLabel.bottomAnchor, constant: 16),
            whereBuyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            whereBuyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18)
        ])
    }
}

// MARK: - ElementCardVCProtocol

extension ElementCardVC: ElementCardVCProtocol {
    func showElement(element: DrugsModel) {
        DispatchQueue.main.async {
            self.titleElementLabel.text = element.name
            self.discriptionElementLabel.text = element.description
            guard let stringImage = element.image else { return }
            let url = "http://shans.d2.i-partner.ru\(stringImage)"
            let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            if let url = URL(string: encodedURL) {
                self.imageOneElement.imageFrom(url: url)
            }
            guard let stringIcon = element.categories?.icon else { return }
            let urlIcon = "http://shans.d2.i-partner.ru\(stringIcon)"
            if let urlIcon = URL(string: urlIcon) {
                self.iconElement.imageFrom(url: urlIcon)
            }
        }
    }
}
