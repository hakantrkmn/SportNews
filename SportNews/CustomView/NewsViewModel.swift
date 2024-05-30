import Foundation

struct NewsItem {
    let webUrl: String
    let webTitle: String
    let sectionName: String
}

class NewsViewModel {
    var newsItems: [NewsItem] = []
    
    func fetchNews(completion: @escaping () -> Void) {
        let newsUrl = "https://content.guardianapis.com/search?section=football&api-key=c5842567-b304-4483-8395-44d6aa050076"
        guard let url = URL(string: newsUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let response = jsonResponse["response"] as? [String: Any],
                   let results = response["results"] as? [[String: Any]] {
                    
                    self.newsItems = results.compactMap { result in
                        return NewsItem(
                            webUrl: result["webUrl"] as? String ?? "",
                            webTitle: result["webTitle"] as? String ?? "No Title",
                            sectionName: result["sectionName"] as? String ?? "No Section"
                        )
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
