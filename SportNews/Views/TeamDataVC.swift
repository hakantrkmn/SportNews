//
//  TeamDataVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 1.05.2024.
//

import UIKit
import SafariServices
import SnapKit
class TeamDataVC: UIViewController {
    
    var teamData : TeamData!
    
    var officialNameLabel = UILabel()
    var imageView = UIImageView()
    var foundedAtLabel = UILabel()
    var stadiumNameLabel = UILabel()
    var marketValueLabel = UILabel()
    var leagueLabel = UILabel()
    var countryLabel = UILabel()
    var tierLabel = UILabel()
    var averageAgeLabel = UILabel()
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
        goURLButton.setTitle("Website", for: .normal)
        goURLButton.setTitleColor(.white, for: .normal)
        goURLButton.backgroundColor = .systemBlue
        goURLButton.layer.cornerRadius = 15
        goURLButton.addTarget(self, action: #selector(goToURl), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    func fetchData(with teamId : String)
    {
        loadingIndicator.startAnimating()
        Task{
            teamData = try await NetworkManager.shared.fetchTeamData(for:teamId)
            set()
            loadingIndicator.stopAnimating()

            
        }
    }
    
    func set()
    {
       
        if teamData != nil
        {
            Task{
                if teamData.image != nil
                {
                    let image = try await NetworkManager.shared.getImage(for: teamData)
                    imageView.image = image
                }
                

            }
            officialNameLabel.text = "Club Name : " + (teamData.officialName ?? teamData.name ?? " ")
            foundedAtLabel.text = "Founded On : " + (teamData.foundedOn ?? " ")
            stadiumNameLabel.text = "Stadium : " + (teamData.stadiumName ?? " ")
            marketValueLabel.text = "Market Value : " + (teamData.currentMarketValue ?? " ")
            leagueLabel.text = "League : " + (teamData.league.name ?? " ")
            countryLabel.text = "Country : " + (teamData.league.countryName ?? " ")
            tierLabel.text = "Tier : " + (teamData.league.tier ?? " ")
            averageAgeLabel.text = "Average Age : " + (teamData.squad.averageAge ?? " ")
        }
       
    }
    
    @objc func goToURl()
    {
        guard let team = teamData else { return}
        
        let svc = SFSafariViewController(url: URL(string: "https://" + team.website!)!)
        svc.modalPresentationStyle = .popover
        svc.popoverPresentationController?.sourceView = self.view
        svc.popoverPresentationController?.sourceRect = CGRectMake(0, view.frame.height, view.frame.width, 100)
        present(svc, animated: true, completion: nil)
    }

    func setUI()
    {
        view.addSubiews(views: officialNameLabel,imageView,foundedAtLabel,stadiumNameLabel,marketValueLabel,loadingIndicator,leagueLabel,countryLabel,tierLabel,averageAgeLabel,goURLButton)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(50)
            make.height.equalTo(300)
        }
        
        officialNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.centerX.equalTo(imageView)
            make.height.equalTo(labelHeight)
        }
        
        foundedAtLabel.snp.makeConstraints { make in
            make.top.equalTo(officialNameLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        marketValueLabel.snp.makeConstraints { make in
            make.top.equalTo(foundedAtLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        leagueLabel.snp.makeConstraints { make in
            make.top.equalTo(marketValueLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(leagueLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        tierLabel.snp.makeConstraints { make in
            make.top.equalTo(countryLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        averageAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(tierLabel.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
        }
        
        goURLButton.snp.makeConstraints { make in
            make.top.equalTo(averageAgeLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(labelHeight)
            make.width.equalTo(100)
        }
        
        
    }
    

}
