//
//  ViewController.swift
//  SportNews
//
//  Created by Hakan Türkmen on 23.04.2024.
//

import UIKit
import SnapKit
import SafariServices
import AppTrackingTransparency


class FeedVC: UIViewController
{
    var textLabel = UILabel()

    
    var daysLabel = UILabel()
    var hoursLabel = UILabel()
    var minutesLabel = UILabel()
    var secondsLabel = UILabel()
    
    var daysText = UILabel()
    var hoursText = UILabel()
    var minutesText = UILabel()
    var secondsText = UILabel()
    
    let targetDate = "2024-06-14 21:00:00" // euro 2024 first match
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if #available(iOS 14, *) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    //print("IDFA STATUS: \(status.rawValue)")
                }
            }
            
        }
        
       
        
        view.backgroundColor = .systemBackground
        daysLabel.textAlignment = .center
        hoursLabel.textAlignment = .center
        minutesLabel.textAlignment = .center
        secondsLabel.textAlignment = .center
        
        daysText.textAlignment = .left
        hoursText.textAlignment = .left
        minutesText.textAlignment = .left
        secondsText.textAlignment = .left
        textLabel.textAlignment = .center

        daysLabel.font = .systemFont(ofSize: 45, weight: .bold)
        hoursLabel.font = .systemFont(ofSize: 45, weight: .bold)
        minutesLabel.font = .systemFont(ofSize: 45, weight: .bold)
        secondsLabel.font = .systemFont(ofSize: 45, weight: .bold)
        
        daysText.text = "DAYS"
        minutesText.text = "MINUTES"
        secondsText.text = "SECONDS"
        hoursText.text = "HOURS"
        textLabel.text = "Euro 2024"
        textLabel.font = .systemFont(ofSize: 50, weight: .bold)
        

        view.addSubiews(views: textLabel,daysLabel,hoursLabel,minutesLabel,secondsLabel,daysText,hoursText,minutesText,secondsText)
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(daysLabel.snp.top)

        }
        
        daysLabel.snp.makeConstraints { make in
            make.trailing.equalTo(hoursLabel.snp.leading)
            //make.height.equalTo(view.snp.width).dividedBy(4)
            make.centerY.equalToSuperview()
        }
        hoursLabel.snp.makeConstraints { make in
            make.leading.equalTo(daysLabel.snp.trailing)
            make.trailing.equalTo(view.snp.centerX)
            make.centerY.equalToSuperview()
        }
        minutesLabel.snp.makeConstraints { make in
            make.leading.equalTo(hoursLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
        secondsLabel.snp.makeConstraints { make in
            make.leading.equalTo(minutesLabel.snp.trailing)
            make.centerY.equalToSuperview()
        }
        
        
        daysText.snp.makeConstraints { make in
            make.trailing.leading.equalTo(daysLabel)
            make.top.equalTo(daysLabel.snp.bottom)
        }
        hoursText.snp.makeConstraints { make in
            make.leading.trailing.equalTo(hoursLabel)
            make.top.equalTo(daysLabel.snp.bottom)
        }
        minutesText.snp.makeConstraints { make in
            make.trailing.leading.equalTo(minutesLabel)
            make.top.equalTo(daysLabel.snp.bottom)
        }
        secondsText.snp.makeConstraints { make in
            make.leading.trailing.equalTo(secondsLabel)

            make.top.equalTo(daysLabel.snp.bottom)
        }
        
        
        // Create a Timer to update the countdown
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
        
        // Call the updateCountdown method immediately to set the initial countdown values
        updateCountdown()
        
        
    }
    
    @objc func updateCountdown() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let targetDate = dateFormatter.date(from: self.targetDate) {
            let currentDate = Date()
            
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: targetDate)
            
            // Update the labels with the remaining time components
            daysLabel.text = String(format: "%02d :", components.day ?? 0)
            hoursLabel.text = String(format: " %02d :", components.hour ?? 0)
            minutesLabel.text = String(format: " %02d :" , components.minute ?? 0)
            secondsLabel.text = String(format: " %02d", components.second ?? 0)
        }
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     */
    
}
