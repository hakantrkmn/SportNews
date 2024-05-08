//
//  SearchClubVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 1.05.2024.
//

import UIKit

class SearchClubVC: UIViewController {
    
    
    
    var searchBar = UISearchController(searchResultsController: nil)
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    var playersTable = UITableView()
    
    var players : TeamSearch?
    
    
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
        playersTable.register(SearchClubTableCell.self, forCellReuseIdentifier: SearchClubTableCell.identifier)
        //let header = SearchTableHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        //playersTable.tableHeaderView = header
        
        setUI()
        
        //header.isHidden = true
        
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
        
        searchBar.searchBar.placeholder = "Search A Club"
        
        navigationItem.searchController = searchBar
    }
    
}



extension SearchClubVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TeamDataVC()
        vc.fetchData(with: players!.results[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchClubTableCell.identifier, for: indexPath) as? SearchClubTableCell else {return UITableViewCell()}
        
        cell.set(with: players!.results[indexPath.row])
        
        return cell
    }
    
    
}
extension SearchClubVC : UISearchResultsUpdating , UISearchBarDelegate
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
                let temp = try await NetworkManager.shared.fetchClubSearch(for: searchBar.text!)
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
