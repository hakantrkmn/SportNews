//
//  SearchVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    var searchBar = UISearchController(searchResultsController: nil)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    var playersTable = UITableView()
    
    var players : PlayerSearch?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setSearchBar()
        playersTable.delegate = self
        playersTable.dataSource = self
        playersTable.tableHeaderView = SearchTableHeader()
        searchBar.searchBar.delegate = self
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        playersTable.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifier)
        let header = SearchTableHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        playersTable.tableHeaderView = header
        
        setUI()
        
        header.isHidden = true
        
    }
    
    
    func setUI()
    {
        view.addSubview(playersTable)
        
        view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        playersTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    func setSearchBar()
    {
        searchBar.searchResultsUpdater = self
        
        searchBar.searchBar.placeholder = "Search A Player"
        
        navigationItem.searchController = searchBar
    }
    
}

extension SearchVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayerDataVC()
        vc.fetchData(with: players!.results[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.identifier, for: indexPath) as? SearchTableCell else {return UITableViewCell()}
        
        cell.set(with: players!.results[indexPath.row])
        
        return cell
    }
    
    
}
extension SearchVC : UISearchResultsUpdating , UISearchBarDelegate
{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Task{
            players?.results.removeAll()
            playersTable.reloadData()
            
            do
            {
                loadingIndicator.startAnimating();
                let temp = try await NetworkManager.shared.fetchPlayerSearch(for: searchBar.text!)
                players = temp
                playersTable.reloadData()
                playersTable.tableHeaderView?.isHidden = false
                
                
                loadingIndicator.stopAnimating();
            }
            catch
            {
                
            }
        }
    }
    
    
    
    
}
