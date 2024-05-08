//
//  News.swift
//  SportNews
//
//  Created by Hakan Türkmen on 24.04.2024.
//

import Foundation

struct News: Codable {
    let title, content, date: String
    let image: String
    let url: String
}


struct NewsAPI: Codable {
    let success: Bool
    let statusCode: Int
    let message: String
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case message, data
    }
}

// MARK: - Datum
struct Datum: Codable {
    let title: String
    let thumbnail: String
    let url: String
}
