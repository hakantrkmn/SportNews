//
//  PlayerDataVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 29.04.2024.
//

import UIKit
import SnapKit
import SafariServices
class PlayerDataVC: UIViewController {

    var playerData : PlayerData!
    
    var fullNameLabel = UILabel()
    var imageView = UIImageView()
    var dateLabel = UILabel()
    var heightLabel = UILabel()
    var ageLabel = UILabel()
    var positionLabel = UILabel()
    var footLabel = UILabel()
    var shirtNumber = UILabel()
    var clubNameLabel = UILabel()
    var goURLButton = UIButton()
    var labelHeight = 30
    
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        imageView.image = UIImage(named: "holder")
        imageView.contentMode = .scaleAspectFit
        view.backgroundColor = .systemBackground
        setUI()
        goURLButton.setTitle("Read More", for: .normal)
        goURLButton.setTitleColor(.white, for: .normal)
        goURLButton.backgroundColor = .systemBlue
        goURLButton.layer.cornerRadius = 15
        goURLButton.addTarget(self, action: #selector(goToURl), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    func fetchData(with playerId : String)
    {
        loadingIndicator.startAnimating()
        Task{
            playerData = try await NetworkManager.shared.fetchPlayerData(for:playerId)
            set()
            loadingIndicator.stopAnimating()

            
        }
    }
    
    func set()
    {
       
        if playerData != nil
        {
            Task{
                if playerData.imageURL != nil
                {
                    let image = try await NetworkManager.shared.getImage(for: playerData)
                    imageView.image = image
                }
                

            }
            fullNameLabel.text = "Name : " + (playerData.fullName ?? playerData.name ?? " ")
            dateLabel.text = "Date Of Birth : " + (playerData.dateOfBirth ?? " ") + " " + (playerData.placeOfBirth.country ?? " ")
            heightLabel.text = "Height : " + (playerData.height ?? " ")
            ageLabel.text = "Age : " + (playerData.age ?? " ")
            positionLabel.text = "Position : " + (playerData.position?.main ?? " ")
            footLabel.text = "Foot : " + (playerData.foot ?? " ")
            shirtNumber.text = "Shirt Number : " + (playerData.shirtNumber ?? " ")
            clubNameLabel.text = "Club Name : " + (playerData.club?.name ?? " ")
        }
       
    }
    
    @objc func goToURl()
    {
        let svc = SFSafariViewController(url: URL(string: playerData.url ?? "")!)
        svc.modalPresentationStyle = .popover
        svc.popoverPresentationController?.sourceView = self.view
        svc.popoverPresentationController?.sourceRect = CGRectMake(0, view.frame.height, view.frame.width, 100)
        present(svc, animated: true, completion: nil)
    }

    func setUI()
    {
        view.addSubiews(views: fullNameLabel,imageView,dateLabel,heightLabel,ageLabel,loadingIndicator,positionLabel,footLabel,shirtNumber,clubNameLabel,goURLButton)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(300)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(imageView)
            make.height.equalTo(labelHeight)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(fullNameLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        footLabel.snp.makeConstraints { make in
            make.top.equalTo(positionLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        shirtNumber.snp.makeConstraints { make in
            make.top.equalTo(footLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        clubNameLabel.snp.makeConstraints { make in
            make.top.equalTo(shirtNumber.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        goURLButton.snp.makeConstraints { make in
            make.top.equalTo(clubNameLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
            make.width.equalTo(100)
        }
        
        
    }
    

}
