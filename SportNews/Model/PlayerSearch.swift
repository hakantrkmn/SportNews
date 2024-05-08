//
//  Player.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import Foundation

struct PlayerSearch: Codable { 
    let query: String
    let pageNumber, lastPageNumber: Int
    var results: [Player]
    let updatedAt: String
}

// MARK: - Result
struct Player: Codable {
    let id, name, position: String
    let club: Club
    let age: String
    let nationalities: [String]
    let marketValue: String
}

// MARK: - Club
struct Club: Codable {
    let name, id: String
}
