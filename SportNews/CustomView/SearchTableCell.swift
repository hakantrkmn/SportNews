//
//  SearchTableCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import UIKit

class SearchTableCell: UITableViewCell {

    public  static var  identifier = "SearchTableCell"


    var nameLabel = UILabel()
    var ageLabel = UILabel()
    var positionLabel = UILabel()
    var clubNameLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameLabel.font = .systemFont(ofSize: 20)
        ageLabel.font = .systemFont(ofSize: 20)
        positionLabel.font = .systemFont(ofSize: 20)
        clubNameLabel.font = .systemFont(ofSize: 20)

        setUI()
    }
    
    func set(with player : Player)
    {
        nameLabel.text = player.name
        ageLabel.text = player.age
        positionLabel.text = player.position
        clubNameLabel.text = player.club.name
    }
    
    func setUI()
    {
        contentView.addSubiews(views: nameLabel,ageLabel,positionLabel,clubNameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(3)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(6)

        }
        
        positionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(contentView).dividedBy(6)

        }
        
        clubNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(positionLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
