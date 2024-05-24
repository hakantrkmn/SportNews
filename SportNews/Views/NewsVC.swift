//
//  NewsVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 11.05.2024.
//

import UIKit

class NewsVC: UIViewController {

    var newsTable = UITableView()
    var news : [News] = []
    
    let refreshControl = UIRefreshControl()
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.register(NewsCell.self, forCellReuseIdentifier: NewsCell.idetifier)
        setUI()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
        Task{
            news = try await NetworkManager.shared.fetchData(at: URL(string: "https://footballnewsapi.netlify.app/.netlify/functions/api/news/onefootball")!)
            newsTable.reloadData()
            loadingIndicator.stopAnimating()
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           newsTable.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        Task{
            news = try await NetworkManager.shared.fetchData(at: URL(string: "https://footballnewsapi.netlify.app/.netlify/functions/api/news/onefootball")!)
            newsTable.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    func setUI()
    {
        view.addSubiews(views: newsTable,loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        newsTable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

 

}
extension NewsVC : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: news[indexPath.row].url) {
            UIApplication.shared.open(url)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.idetifier, for: indexPath) as? NewsCell else  {return UITableViewCell()}
        
        cell.set(with: news[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
