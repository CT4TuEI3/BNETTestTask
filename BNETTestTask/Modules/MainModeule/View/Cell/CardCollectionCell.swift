//
//  CollectionViewCell.swift
//  BNETTestTask
//
//  Created by Алексей on 28.04.2023.
//

import UIKit

final class CardCollectionCell: UICollectionViewCell {
    
    // MARK: - UI elements
    
    private let cellUIImageView = UIImageView()
    private let largeLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let uiContainer = UIStackView()
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellUIImageView.image = nil
    }
    
    
    // Configure
    
    func configure(model: DrugsModel) {
        self.largeLabel.text = model.name
        self.descriptionLabel.text = model.description
        guard let stringImage = model.image else { return }
        let url = "http://shans.d2.i-partner.ru\(stringImage)"
        let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        if let url = URL(string: encodedURL) {
            self.cellUIImageView.imageFrom(url: url)
        }
    }
    
    
    // MARK: Private methods
    
    private func setupUI() {
        backgroundColor = Colors.globalWhite
        addSubview(cellUIImageView)
        addSubview(largeLabel)
        addSubview(descriptionLabel)
        addShadow()
        settingsLabels()
        setConstraints()
        layer.cornerRadius = 8
        cellUIImageView.contentMode = .scaleAspectFit
        cellUIImageView.layer.cornerRadius = 8
    }
    
    private func settingsLabels() {
        
        largeLabel.textColor = Colors.globalBlack
        largeLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        largeLabel.numberOfLines = 0
        largeLabel.setContentHuggingPriority(.required, for: .vertical)
        
        descriptionLabel.textColor = Colors.globalLightGray
        descriptionLabel.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        descriptionLabel.numberOfLines = 6
    }
    
    private func setConstraints() {
        cellUIImageView.translatesAutoresizingMaskIntoConstraints = false
        largeLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellUIImageView.heightAnchor.constraint(equalToConstant: 82),
            cellUIImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cellUIImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cellUIImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            largeLabel.topAnchor.constraint(equalTo: cellUIImageView.bottomAnchor, constant: 12),
            largeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            largeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            descriptionLabel.topAnchor.constraint(equalTo: largeLabel.bottomAnchor, constant: 6),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
}
