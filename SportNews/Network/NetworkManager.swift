//
//  NetworkManager.swift
//  SportNews
//
//  Created by Hakan Türkmen on 24.04.2024.
//

import UIKit

class NetworkManager
{
    static let shared = NetworkManager()

    let cache = NSCache<NSString,UIImage>()

    func getNews() -> [News]
    {
        let news = Bundle.main.url(forResource: "news", withExtension: "json")
        let data = try? Data(contentsOf: news!)
        let person = try? JSONDecoder().decode([News].self, from: data!)
        return person!
    }
    
    
  
    func getNewsWithUrl() async throws -> NewsAPI?
    {
        let url = URL(string: "https://ligaindonesia-api.vercel.app/api/v1/news")

            let (data, _) = try await URLSession.shared.data(from: url!)
            let playerSearch = try? JSONDecoder().decode(NewsAPI.self, from: data)
            return playerSearch
        
    }
    
     func getImage(for news : Datum) async throws -> UIImage?
    {
        if let imagee = cache.object(forKey: NSString(string: news.title))
        {
            print("hakan")
            return imagee

        }
        else
        {
            let (data, _) = try await URLSession.shared.data(from: URL(string: news.thumbnail)!)
            guard let image = UIImage(data: data) else {
                throw ImageError.invalidData
            }
            cache.setObject(image, forKey: NSString(string: news.title))
            return image
        }
        
        
        
    }
    
    
    func getImage(for teamData : TeamData) async throws -> UIImage?
   {
      
       let (data, _) = try await URLSession.shared.data(from: URL(string: teamData.image ?? "")!)
           guard let image = UIImage(data: data) else {
               throw ImageError.invalidData
           }
           return image
       
       
       
       
   }
    
    func getImage(for playerData : PlayerData) async throws -> UIImage?
   {
      
           let (data, _) = try await URLSession.shared.data(from: URL(string: playerData.imageURL ?? "")!)
           guard let image = UIImage(data: data) else {
               throw ImageError.invalidData
           }
           return image
       
       
       
       
   }
    
        
    func fetchPlayerSearch(for playerName : String) async throws -> PlayerSearch?
    {
        let baseUrl = "https://transfermarkt-api.fly.dev/players/search/"
        
        print(baseUrl + playerName + "?page_number=1")
            let (data, _) = try await URLSession.shared.data(from: URL(string: baseUrl + playerName + "?page_number=1")!)
            let playerSearch = try? JSONDecoder().decode(PlayerSearch.self, from: data)
            return playerSearch
        
    }
    
    
func fetchClubSearch(for clubName : String) async throws -> TeamSearch?
{

    let baseUrl = "https://transfermarkt-api.fly.dev/clubs/search/"
    
        let (data, _) = try await URLSession.shared.data(from: URL(string: baseUrl + clubName + "?page_number=1")!)
        let playerSearch = try? JSONDecoder().decode(TeamSearch.self, from: data)
        return playerSearch
    
}
    
    

    func fetchPlayerData(for playerId : String) async throws -> PlayerData?
    {
        let baseUrl = "https://transfermarkt-api.fly.dev/players/"
        
        print(baseUrl + playerId + "/profile")
        
            let (data, _) = try await URLSession.shared.data(from: URL(string: baseUrl + playerId + "/profile")!)
            let playerSearch = try?  JSONDecoder().decode(PlayerData.self, from: data)
            return playerSearch
        
        
    }
    
    func fetchTeamData(for teamId : String) async throws -> TeamData?
    {

        let baseUrl = "https://transfermarkt-api.fly.dev/clubs/"
        
        
            let (data, _) = try await URLSession.shared.data(from: URL(string: baseUrl + teamId + "/profile")!)
            let playerSearch = try?  JSONDecoder().decode(TeamData.self, from: data)
            return playerSearch
        
        
    }
}
