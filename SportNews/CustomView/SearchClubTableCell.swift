//
//  SearchClubTableCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 1.05.2024.
//

import UIKit

class SearchClubTableCell: UITableViewCell {
    
    public  static var  identifier = "SearchClubTableCell"


    var nameLabel = UILabel()
    var ageLabel = UILabel()
    var positionLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.font = .systemFont(ofSize: 20)
        ageLabel.font = .systemFont(ofSize: 20)
        positionLabel.font = .systemFont(ofSize: 20)

        setUI()
    }
    
    func set(with team : Team)
    {
        nameLabel.text = team.name
        ageLabel.text = team.country
        positionLabel.text = team.marketValue
    }
    
    func setUI()
    {
        contentView.addSubiews(views: nameLabel,ageLabel,positionLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(3)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(3)

        }
        
        positionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(3)

        }
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
