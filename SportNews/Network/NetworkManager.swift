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
        var news = Bundle.main.url(forResource: "news", withExtension: "json")
        let data = try? Data(contentsOf: news!)
        let person = try? JSONDecoder().decode([News].self, from: data!)
        return person!
    }
    
     func getImage(for news : News) async throws -> UIImage?
    {
        if let imagee = cache.object(forKey: NSString(string: news.title))
        {
            print("hakan")
            return imagee

        }
        else
        {
            let (data, _) = try await URLSession.shared.data(from: URL(string: news.image)!)
            guard let image = UIImage(data: data) else {
                throw ImageError.invalidData
            }
            cache.setObject(image, forKey: NSString(string: news.title))
            return image
        }
        
        
        
    }
    
}
