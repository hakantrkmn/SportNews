//
//  TriviaCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 26.05.2024.
//

import UIKit
import SnapKit
class TriviaCell: UICollectionViewCell {
    static let identifier = "TriviaCell"
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .systemBlue
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with text : String)
    {
        label.text = text
    }
    
}
