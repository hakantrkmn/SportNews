//
//  GroupCell.swift
//  SportNews
//
//  Created by Hakan Türkmen on 2.05.2024.
//

import UIKit



class GroupCell: UITableViewCell {
    
    static let identifier = "GroupCell"
    enum RowType {
        case title
        case stats
        case team
    }

    // Create a vertical stack view to hold multiple rows
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // You can customize the appearance of each row as needed
    func addRow(withText text: String, rowType: RowType) {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.spacing = 10
     
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        
        // Use the custom Barlow font
          if let customFont = UIFont(name: "YourCustomFontName", size: 18) {
              label.font = customFont
          } else {
              // Fallback to system font if the custom font is not available
              label.font = UIFont.systemFont(ofSize: 18)
          }

        switch rowType {
        case .title:
            if let customFont = UIFont(name: "Barlow-SemiBold", size: 20) {
                     label.font = customFont
                 } else {
                     label.font = UIFont.boldSystemFont(ofSize: 20) // fallback to system font
                 }
            label.textAlignment = .left
        case .stats:
            if let customFont = UIFont(name: "Barlow-Medium", size: 11) {
                     label.font = customFont
                 } else {
                     label.font = UIFont.boldSystemFont(ofSize: 11) // fallback to system font
                 }
            label.font = UIFont.systemFont(ofSize: 11)
            label.textAlignment = .right
        case .team:
            if let customFont = UIFont(name: "Barlow-Medium", size: 16) {
                     label.font = customFont
                 } else {
                     label.font = UIFont.boldSystemFont(ofSize: 16) // fallback to system font
                 }
            label.textAlignment = .left
        }

        rowStackView.addArrangedSubview(label)
        mainStackView.addArrangedSubview(rowStackView)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    
    }
    

    // Implementation of init(coder:)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        contentView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    


}
