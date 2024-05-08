//
//  ViewController.swift
//  SportNews
//
//  Created by Hakan Türkmen on 23.04.2024.
//

import UIKit
import SnapKit
import SafariServices
import AppTrackingTransparency
class FeedVC: UIViewController
{
    
    var newsTable = UITableView()
    var news : NewsAPI?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUI()
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(NewsTableCell.self, forCellReuseIdentifier: NewsTableCell.identifier)
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                ATTrackingManager.requestTrackingAuthorization { (status) in
                  //print("IDFA STATUS: \(status.rawValue)")
                }
            }
          
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setUI()
    {
        view.addSubview(newsTable)
        newsTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchNews()
    }

    func fetchNews()
    {
        Task
        {
            do{
                news = try await NetworkManager.shared.getNewsWithUrl()
                dump(news)
                newsTable.reloadData()
            }
            catch{
                
            }
         

        }
    }

}

extension FeedVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableCell.identifier, for: indexPath) as? NewsTableCell else {return UITableViewCell()}
        guard let newsapi = news else {return UITableViewCell()}
        print("hakantrkmn")
        cell.set(with: newsapi.data[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//
//        let vc = NewsDetailVC()
//        vc.news = news[indexPath.row]
//        navigationController?.pushViewController(vc, animated: true)
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}
