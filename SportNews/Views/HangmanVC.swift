import UIKit

class HangmanVC: UIViewController {
    
    var hangmanWordLabel: UILabel!
    var inputTextField: UITextField!
    var takeLetterButton: UIButton!
    var takeHintButton: UIButton!
    
    var footballPlayers = ["MESSI", "RONALDO", "NEYMAR", "MBAPPE", "HAZARD", "SALAH", "LEWANDOWSKI", "DE BRUYNE", "KANE", "HAALAND", "NEYMAR", "SUAREZ", "MODRIC", "NEYMAR", "GRIEZMANN", "VAN DIJK", "RAMOS", "SANE", "OBLAK", "KROOS", "FIRMINO", "STERLING", "DE JONG", "CASILLAS", "INIESTA", "MANE", "DE GEA", "ALISSON", "AUBAMEYANG", "POGBA"]
    var currentWord: String!
    var guessedLetters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        startNewGame()
        inputTextField.delegate = self
    }
    
    func setupUI() {
        // Hangman Word Label
        hangmanWordLabel = UILabel()
        hangmanWordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hangmanWordLabel)
        
        NSLayoutConstraint.activate([
            hangmanWordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor , constant: -100),
            hangmanWordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Input Text Field
        inputTextField = UITextField()
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.placeholder = "Enter a letter or guess the word"
        inputTextField.autocapitalizationType = .allCharacters
        inputTextField.borderStyle = .roundedRect
        view.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: hangmanWordLabel.bottomAnchor, constant: 20),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Take Letter Button
        takeLetterButton = UIButton(type: .system)
        takeLetterButton.translatesAutoresizingMaskIntoConstraints = false
        takeLetterButton.setTitle("Guess", for: .normal)
        takeLetterButton.addTarget(self, action: #selector(takeLetterButtonTapped), for: .touchUpInside)
        view.addSubview(takeLetterButton)
        
        NSLayoutConstraint.activate([
            takeLetterButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            takeLetterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        // Take Hint Button
        takeHintButton = UIButton(type: .system)
        takeHintButton.translatesAutoresizingMaskIntoConstraints = false
        takeHintButton.setTitle("Take a Letter", for: .normal)
        takeHintButton.addTarget(self, action: #selector(takeHintButtonTapped), for: .touchUpInside)
        view.addSubview(takeHintButton)
        
        NSLayoutConstraint.activate([
            takeHintButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 20),
            takeHintButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        let descriptionLabel = UILabel()
           descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
           descriptionLabel.text = "Guess the name of the soccer player! Click on TAKE A HINT for help."
           descriptionLabel.numberOfLines = 0
           descriptionLabel.textAlignment = .center
           view.addSubview(descriptionLabel)
           
           NSLayoutConstraint.activate([
               descriptionLabel.topAnchor.constraint(equalTo: takeLetterButton.bottomAnchor, constant: 20),
               descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
           ])
        
    }
    
    func startNewGame() {
        guessedLetters.removeAll()
        currentWord = footballPlayers.randomElement()
        updateHangmanWordLabel()
    }
    func updateHangmanWordLabel() {
        guard let currentWord = currentWord else {
            return
        }
        var displayedWord = ""
        for char in currentWord {
            if guessedLetters.contains(char) {
                displayedWord.append(char)
            } else {
                displayedWord.append("_")
            }
            displayedWord.append(" ") // Add a space after each letter or dash
        }
        // Remove the extra space at the end
        displayedWord.removeLast()
        hangmanWordLabel.text = displayedWord
    }
    
    func checkGameStatus() {
        guard let currentWord = currentWord else {
            return
        }
        if currentWord.allSatisfy({ guessedLetters.contains($0) }) {
            // All letters guessed correctly, restart the game
            let alertController = UIAlertController(title: "Congratulations!", message: "You guessed the word!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                self.startNewGame()
            }))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func takeLetterButtonTapped() {
        guard let inputText = inputTextField.text?.uppercased() else {
            return
        }
        
        inputTextField.text = ""
        
        if inputText.count > 1 {
            // Player guesses the whole word
            if inputText == currentWord {
                // Guessed correctly
                let alertController = UIAlertController(title: "Congratulations!", message: "You guessed the word!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                    self.startNewGame()
                }))
                present(alertController, animated: true, completion: nil)
            } else {
                // Guessed incorrectly
                let alertController = UIAlertController(title: "Wrong Guess", message: "Try again!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        } else {
            // Player guesses a letter
            guard let letter = inputText.first else {
                return
            }
            
            if !guessedLetters.contains(letter) {
                guessedLetters.append(letter)
                updateHangmanWordLabel()
                checkGameStatus()
            }
        }
    }
    
    @objc func takeHintButtonTapped() {
        guard let currentWord = currentWord else {
            return
        }
        // Find a letter from the word that hasn't been guessed yet
        let unguessedLetters = currentWord.filter { !guessedLetters.contains($0) }
        if let hintLetter = unguessedLetters.first {
            guessedLetters.append(hintLetter)
            updateHangmanWordLabel()
            checkGameStatus()
        }
    }
}

extension HangmanVC : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        takeLetterButtonTapped()
        return true
        
    }
}
