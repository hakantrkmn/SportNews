//
//  SearchTableHeader.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import UIKit

class SearchTableHeader: UIView {

    public  static var  identifier = "SearchTableHeader"


    var nameLabel = UILabel()
    var ageLabel = UILabel()
    var positionLabel = UILabel()
    var clubNameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.font = .systemFont(ofSize: 20)
        ageLabel.font = .systemFont(ofSize: 20)
        positionLabel.font = .systemFont(ofSize: 20)
        clubNameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textAlignment = .center
        ageLabel.textAlignment = .center
        positionLabel.textAlignment = .center
        clubNameLabel.textAlignment = .center

        nameLabel.textColor = .systemRed
        ageLabel.textColor = .systemRed
        positionLabel.textColor = .systemRed
        clubNameLabel.textColor = .systemRed

        setUI()
        set()
    }

    
  
   
    
    func set()
    {
        nameLabel.text = "Name"
        ageLabel.text = "Age"
        positionLabel.text = "Position"
        clubNameLabel.text = "Club"
    }
    
    func setUI()
    {
        addSubiews(views: nameLabel,ageLabel,positionLabel,clubNameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self).dividedBy(3)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self).dividedBy(6)

        }
        
        positionLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self).dividedBy(6)

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
