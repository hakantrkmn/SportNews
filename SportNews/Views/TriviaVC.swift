//
//  TriviaVC.swift
//  SportNews
//
//  Created by Hakan Türkmen on 26.05.2024.
//

import UIKit
import SnapKit

class TriviaVC: UIViewController
{

    var question = Question(question: "premier ligi kim aldı", options: ["ali","ahmet","hasan"], correctAnswer: 0, image: "bes")
    
    var questionLabel = UILabel()
    
    var imageView = UIImageView()

    
    var optionsStack : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        setUI()
        getQuestion()
        questionLabel.textAlignment = .center
        questionLabel.font = .systemFont(ofSize: 25)
        questionLabel.numberOfLines = 0
        questionLabel.text = question.question
        
        optionsStack.delegate = self
        optionsStack.dataSource = self
        
        imageView.contentMode = .scaleAspectFill
       
        optionsStack.register(TriviaCell.self, forCellWithReuseIdentifier: TriviaCell.identifier)
    }
    
   
    
    func getQuestion()
    {
        for i in 0..<4
        {
            let cell = optionsStack.cellForItem(at: IndexPath(item: i, section: 0))
            cell?.layer.backgroundColor = UIColor.blue.cgColor

        }
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([Question].self, from: data)
                    self.question = jsonData.randomElement()!
                    optionsStack.reloadData()
                } catch {
                    print("error:\(error)")
                }
            }
    }

    func setUI()
    {
        view.addSubiews(views: questionLabel,optionsStack,imageView)
        
        questionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(-view.frame.height / 4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.5)
        }
        
        optionsStack.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(questionLabel)
            make.height.equalTo(view.snp.height).dividedBy(5)
        }
        
        imageView.snp.makeConstraints { make in
            
            make.top.equalTo(optionsStack.snp.bottom).offset(20)
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        
      
    }
   

}

extension TriviaVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.height/2 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return question.options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TriviaCell.identifier, for: indexPath) as? TriviaCell else {return UICollectionViewCell()}
        cell.set(with: question.options[indexPath.row])
        imageView.image = UIImage(named: question.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath)
        if indexPath.row == question.correctAnswer
        {
          
            cell?.layer.backgroundColor = UIColor.green.cgColor
            let alert = UIAlertController(title: "Correct", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Next", style: UIAlertAction.Style.default, handler: { action in
                self.getQuestion()
            }))  
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
          
            cell?.layer.backgroundColor = UIColor.red.cgColor
            let correctCell = collectionView.cellForItem(at: IndexPath(item: question
                .correctAnswer, section: 0))
            correctCell?.layer.backgroundColor = UIColor.green.cgColor
            let alert = UIAlertController(title: "Wrong Answer", message: "", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Again", style: UIAlertAction.Style.default, handler: { action in
                self.getQuestion()
            }))
            self.present(alert, animated: true, completion: nil)

        }
            
    }
    
    
    
}
