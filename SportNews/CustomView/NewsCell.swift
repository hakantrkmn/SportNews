//
//  NewsCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 11.05.2024.
//

import UIKit

class NewsCell: UITableViewCell {

    static let idetifier = "NewsCell"
    
    var img = UIImageView()
    var titleLabel = UILabel()
    
    
    func set(with news : News)
    {
        Task{
            do{
                print("hakan")
                img.image = try await NetworkManager.shared.fetchImage(at: URL(string: news.img)!)
                titleLabel.text = news.title
            }
            catch{
                print(error)
            }

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        img.contentMode = .scaleAspectFit

        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI()
    {
        contentView.addSubiews(views: img,titleLabel)
        
        
        img.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.bottom.trailing.top.equalToSuperview().inset(10)
        }
    }

}
