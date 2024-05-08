//
//  GuessPlayerVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 5.05.2024.
//

import UIKit

class GuessPlayerVC: UIViewController {

    var imageView = UIImageView()
    
    var guessLabel = UILabel()
    
    var guessText = UITextField()
    
    let picker = UIPickerView()
    
    var guessButton = UIButton()
    
    let players = ["ronaldo","messi","martinez","lewandowski","grealish","foden","arda","mbappe","griezmann"]
    var lastPlayer = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        picker.delegate = self
        picker.dataSource = self
        setUI()
        guessText.layer.borderWidth = 1
        guessText.inputView = picker
        guessText.tintColor = .clear
        guessLabel.text = "Guess The Player"
        guessLabel.font = .systemFont(ofSize: 20)
        guessLabel.textAlignment = .center
        
        guessButton.setTitle("Guess", for: .normal)
        guessButton.setTitleColor(.white, for: .normal)
        guessButton.backgroundColor = .systemBlue
        guessButton.layer.cornerRadius = 15
        
        guessText.textAlignment = .center
        getRandomPlayer()
        
        picker.selectRow(0, inComponent: 0, animated: true)
        guessText.text = players.first?.uppercased()
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        guessButton.addTarget(self, action: #selector(guessTapped), for: .touchUpInside)
    }
    
    @objc func guessTapped()
    {
            if guessText.text?.uppercased() == lastPlayer.uppercased()
        {
            print("doğru")
                let alert = UIAlertController(title: "Correct", message:"", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                        UIAlertAction in
                    self.getRandomPlayer()
                    }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
        }
        else
        {
            let alert = UIAlertController(title: "Wrong Guess", message:"", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    func getRandomPlayer()
    {
        if lastPlayer == ""
        {
            let rand = players.randomElement()
            imageView.image = UIImage(named: rand!)
            lastPlayer = rand!
        }
        else
        {
            let rand = players.filter{$0 != lastPlayer}.randomElement()
            imageView.image = UIImage(named: rand!)
            lastPlayer = rand!
        }
    }
    func setUI()
    {
        view.addSubiews(views: imageView,guessText,guessLabel,guessButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        guessLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        guessText.snp.makeConstraints { make in
            make.top.equalTo(guessLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(100)
        }
        
        guessButton.snp.makeConstraints { make in
            make.top.equalTo(guessText.snp.bottom).offset(50)
            make.height.equalTo(50)
            make.width.equalTo(90)
            make.centerX.equalToSuperview()
        }
    }
    

   

}

extension GuessPlayerVC : UIPickerViewDelegate , UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        players.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return players[row].uppercased()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guessText.text = players[row].uppercased()
    }
    
    
}
