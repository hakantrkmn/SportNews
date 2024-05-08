//
//  GroupsVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 2.05.2024.
//

import UIKit
import SnapKit

class GroupsVC: UIViewController,UITableViewDataSource {
    
    var tableView = UITableView()
    
    
    let groups: [Group] = [
        Group(name: "Group A", teams: ["🇩🇪 Germany", "🏴󠁧󠁢󠁳󠁣󠁴󠁿 Scotland", "🇭🇺 Hungary", "🇨🇭 Switzerland"]),
        Group(name: "Group B", teams: ["🇪🇸 Spain", "🇭🇷 Croatia", "🇮🇹 Italy", "🇦🇱 Albania"]),
        Group(name: "Group C", teams: ["🇸🇮 Slovenia", "🇩🇰 Denmark", "🇷🇸 Serbia", "🏴󠁧󠁢󠁥󠁮󠁧󠁿 England"]),
        Group(name: "Group D", teams: ["🏳️ Play-off Winner A", "🇳🇱 Netherlands", "🇦🇹 Austria", "🇫🇷 France"]),
        Group(name: "Group E", teams: ["🇧🇪 Belgium", "🇸🇰 Slovakia", "🇷🇴 Romania", "🏳️ Play-off Winner B"]),
        Group(name: "Group F", teams: ["🇹🇷 Türkiye", "🏳️ Play-off Winner C", "🇵🇹 Portugal", "🇨🇿 Czechia"]),
        
    ]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        
        // Clear existing rows in the cell
        for subview in cell.mainStackView.arrangedSubviews {
              subview.removeFromSuperview()
          }
        
        // Add group title row
        cell.addRow(withText: groups[indexPath.row].name, rowType: .title)

        // Add stats row
        cell.addRow(withText: "W L", rowType: .stats)
        
        // Add 4 teams for each group
        // Add teams for the current group
              for teamName in groups[indexPath.row].teams {
                  cell.addRow(withText: teamName, rowType: .team)
              }

        // Return the cell for use in the respective table view row
           return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        // Set the bar background color
        
        
    }
    


}
