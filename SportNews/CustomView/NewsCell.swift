import UIKit
import LinkPresentation

class NewsCell: UITableViewCell {
    static let identifier = "NewsCell"
    
    private let linkPreview: LPLinkView = {
        let view = LPLinkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sectionLabel)
        contentView.addSubview(linkPreview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            sectionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            sectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            sectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            linkPreview.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 10),
            linkPreview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            linkPreview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            linkPreview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            linkPreview.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with newsItem: NewsItem) {
        titleLabel.text = newsItem.webTitle
        sectionLabel.text = newsItem.sectionName
        
        if let url = URL(string: newsItem.webUrl) {
            let provider = LPMetadataProvider()
            provider.startFetchingMetadata(for: url) { metadata, error in
                guard let data = metadata, error == nil else { return }
                DispatchQueue.main.async {
                    self.linkPreview.metadata = data
                }
            }
        }
    }
}
