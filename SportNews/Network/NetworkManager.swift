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

    func fetchData(at url: URL) async throws -> [News]
    {
        let (data,_) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode([News].self, from: data)
        
        return result

        
    }
    
    func fetchImage(at url: URL) async throws -> UIImage
    {
        let (data,_) = try await URLSession.shared.data(from: url)
       
        return UIImage(data: data)!

        
    }
    
  
}
