//
//  NewsTableCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 23.04.2024.
//

import UIKit
import SnapKit

class NewsTableCell: UITableViewCell {

    public  static var  identifier = "NewsTableCell"
    
    var news : Datum!
    var headline = UILabel()
    var date = UILabel()
    var content = UILabel()
    var image = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUI()

    }
    
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func set(with news : Datum)
    {
        self.news = news
        headline.text = self.news.title
        //content.text = self.news.content
        //date.text = self.news.date.convertFormattedDate()
       
            Task{
                do{
                    image.image = try await NetworkManager.shared.getImage(for: news)
                    

                    
                }
                catch{
                    print("sıkıntı  var")
                }

            }
        
            
        
        
           
        
        headline.font = .systemFont(ofSize: 15, weight: .heavy)
        content.numberOfLines = 0
        image.contentMode = .scaleAspectFit
        

    }
    func setUI()
    {
        contentView.addSubiews(views: image,headline,date,content)
        
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        headline.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalToSuperview()
            make.bottom.equalTo(date.snp.top)
        }
    
        
        date.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
    }

}
