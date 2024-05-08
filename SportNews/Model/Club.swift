//
//  Club.swift
//  SportNews
//
//  Created by Hakan Türkmen on 1.05.2024.
//

import Foundation


struct TeamSearch: Codable {
    let query: String
    let pageNumber, lastPageNumber: Int
    var results: [Team]
    let updatedAt: String
}

// MARK: - Result
struct Team: Codable {
    let id, url, name: String
    let country: String
    let squad: String
    let marketValue: String
}

struct TeamData: Codable {
    let id, url, name, officialName: String?
    let image: String?
    let legalForm, addressLine1, addressLine2, addressLine3: String?
    let tel, fax, website, foundedOn: String?
    let members, membersDate: String?
    let otherSports, colors: [String]?
    let stadiumName, stadiumSeats, currentTransferRecord, currentMarketValue: String?
    let squad: Squad
    let league: League
    let historicalCrests: [String]?
    let updatedAt: String?
}

// MARK: - League
struct League: Codable {
    let id, name, countryID, countryName: String?
    let tier: String?
}

// MARK: - Squad
struct Squad: Codable {
    let size, averageAge, foreigners, nationalTeamPlayers: String?
}
