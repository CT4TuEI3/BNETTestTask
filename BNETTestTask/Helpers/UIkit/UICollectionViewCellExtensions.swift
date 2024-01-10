//
//  UICollectionViewCellExtensions.swift
//  BNETTestTask
//
//  Created by Алексей on 29.04.2023.
//

import UIKit

extension UICollectionViewCell {
    func addShadow(corner: CGFloat = 4,
                   color: UIColor = Colors.globalBlack,
                   radius: CGFloat = 8,
                   offset: CGSize = CGSize(width: 0, height: 0),
                   opacity: Float = 0.2) {
        let cell = self
        cell.contentView.layer.borderWidth = 0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = color.cgColor
        cell.layer.shadowOffset = offset
        cell.layer.shadowRadius = radius
        cell.layer.shadowOpacity = opacity
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                             cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
}
