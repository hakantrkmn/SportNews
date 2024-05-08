//
//  PlayerData.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import Foundation


// MARK: - Welcome
struct PlayerData: Codable {
    let id: String?
    let url: String?
    let name, description, fullName: String?
    let imageURL: String?
    let dateOfBirth: String?
    let placeOfBirth: PlaceOfBirth
    let age, height: String?
    let citizenship: [String]?
    let isRetired: Bool?
    let position: Position?
    let foot, shirtNumber: String?
    let club: ClubData?
    let marketValue: String?
    let agent: Agent?
    let outfitter: String?
    
    let socialMedia: [String]?
    let updatedAt: String?
}

// MARK: - Agent
struct Agent: Codable {
    let name, url: String?
}

// MARK: - Club
struct ClubData: Codable {
    let id, name, joined, contractExpires: String?
}

// MARK: - PlaceOfBirth
struct PlaceOfBirth: Codable {
    let city, country: String?
}

// MARK: - Position
struct Position: Codable {
    let main: String?
    let other: [String]?
}
