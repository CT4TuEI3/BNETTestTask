//
//  Model.swift
//  BNETTestTask
//
//  Created by Алексей on 30.04.2023.
//

import Foundation

struct DrugsModel: Decodable {
    let id: Int?
    let image: String?
    let categories: Categories?
    let name: String?
    let description: String?
    let documentation: String?
    let fields: [Field]?
}

struct Categories: Decodable {
    let id: Int?
    let icon: String?
    let image: String?
    let name: String?
}

struct Field: Decodable {
    let type: String?
    let name: String?
    let value: String?
    let image: String?
}

struct CardOneElementModel: Decodable {
    let id: Int?
    let image: String?
    let name: String?
    let description: String?
    let documentation: String?
    let categories: Categories?
}
