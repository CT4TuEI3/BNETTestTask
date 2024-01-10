//
//  NetworkService.swift
//  BNETTestTask
//
//  Created by Алексей on 01.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getDrugsList(offset: Int, limit: Int, completion: @escaping ([DrugsModel]) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func getDrugsList(offset: Int, limit: Int, completion: @escaping ([DrugsModel]) -> Void) {
        let getLisURL = "http://shans.d2.i-partner.ru/api/ppp/index/?offset=\(offset)&limit=\(limit)"
        guard let url = URL(string: getLisURL) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data else { return }
            if let drugData = try? JSONDecoder().decode([DrugsModel].self, from: data) {
                completion(drugData)
            } else {
                print("Error parsing")
            }
        }
        task.resume()
    }
}
