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
