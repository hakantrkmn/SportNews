//
//  NewsDetailVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 23.04.2024.
//

import UIKit
import SnapKit
import SafariServices
import LinkPresentation

class NewsDetailVC: UIViewController
{

    var image = UIImageView()
    var headline = UILabel()
    var content = UILabel()
    var screenShot : UIImage?
    var goToURLButton = UIButton(type: .system)
    var share = UIButton(type: .system)
    var containerView = UIView()
    var news : News!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUI()
        goToURLButton.addTarget(self, action: #selector(goToURl), for: .touchUpInside)
        share.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)

        set()
        title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
      
    }
    func set()
    {
        headline.text = self.news.title
        content.text = self.news.content
//        if(image.image == nil)
//        {
//            Task{
//                do{
//                    image.image = try await NetworkManager.shared.getImage(for: news)
//                    print("hakan")
//                }
//                catch{
//                    print("sıkıntı  var")
//                }
//
//            }
//        }
        
        headline.font = .systemFont(ofSize: 15, weight: .heavy)
        content.numberOfLines = 0
        content.sizeToFit()
        content.minimumScaleFactor = 0.5
        content.textAlignment = .left
        image.contentMode = .scaleAspectFit
        goToURLButton.setTitle("Read", for: .normal)
        goToURLButton.setTitleColor(.white, for: .normal)
        goToURLButton.backgroundColor = .systemBlue
        goToURLButton.layer.cornerRadius = 15
        
        share.setTitle("Share", for: .normal)
        share.setTitleColor(.white, for: .normal)
        share.backgroundColor = .systemBlue
        share.layer.cornerRadius = 15
        

    }
    
    @objc func goToURl()
    {
        let svc = SFSafariViewController(url: URL(string: news?.url ?? "")!)
        svc.modalPresentationStyle = .popover
        svc.popoverPresentationController?.sourceView = self.view
        svc.popoverPresentationController?.sourceRect = CGRectMake(0, view.frame.height, view.frame.width, 100)
        present(svc, animated: true, completion: nil)
    }
    
    @objc func shareTapped()
    {
        self.screenShot = containerView.screenshot()
        

        let share = UIActivityViewController(activityItems: [self.screenShot, self], applicationActivities: nil)
        share.excludedActivityTypes = [.saveToCameraRoll]
        share.popoverPresentationController?.sourceView = self.view
        share.modalPresentationStyle = .formSheet
        share.popoverPresentationController?.sourceRect = CGRectMake(0, view.frame.height, view.frame.width, 100) // change the rect to the frame you want the view to appear
        Task{
            present(share, animated: true, completion: nil)
            
        }
    }


    func setUI()
    {
        view.addSubiews(views: containerView,goToURLButton,share)
        containerView.addSubiews(views: image,headline,content)
        
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(100)
        }
        image.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        headline.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalTo(headline.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            
        }
        
        goToURLButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            //make.centerX.equalToSuperview()
            make.leading.equalTo(view.snp.centerX).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        share.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.trailing.equalTo(view.snp.centerX).offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    
}
extension NewsDetailVC : UIActivityItemSource
{
    // MARK: Activity Item protocols
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return nil
        
    }
    
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        
        let imageProvider = NSItemProvider(object: screenShot!)
        
        let metadata = LPLinkMetadata()
        metadata.title = "Description of image to share" // Preview Title
        
        
        metadata.imageProvider = imageProvider
        return metadata
    }
}
