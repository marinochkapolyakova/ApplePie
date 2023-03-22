//
//  ViewController.swift
//  ApplePie
//
//  Created by marinapolyakova on 16.03.2023.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentGame : Game!
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLoses = 0 {
        didSet{
            newRound()
        }
    }
    var listOfWords = [
        "Александрия",
        "Атланта",
        "Ахмедабад",
        "Багдад",
        "Бангалор",
        "Бангкок",
        "Барселона",
        "Белу-Оризонти",
        "Богота",
        "Буэнос-Айрес",
        "Вашингтон",
        "Гвадалахара",
        "Гонконг",
        "Гуанчжоу",
        "Дакка",
        "Даллас",
        "Далянь",
        "Дар-эс-Салам",
        "Дели",
        "Джакарта",
        "Дунгуань",
        "Йоханнесбург",
        "Каир",
        "Калькутта",
        "Карачи",
        "Киншаса",
        "Куала Лумпур",
        "Лагос",
        "Лахор",
        "Лима",
        "Лондон",
        "Лос-Анджелес",
        "Луанда"
    ].shuffled()
    
    func enableButtons(_ enable: Bool = true){
        for button in letterButtons{
            button.isEnabled = true
        }
    }
    
    
    func newRound(){
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeLast()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    
    func updateCorrectWordLabel(){
        var displayWord = [String]()
        for letter in currentGame.guessedWord{
            displayWord.append(String(letter))
        }
        correctWordLabel.text = displayWord.joined(separator: " ")
    }
    
    func updateState(){
        if currentGame.incorrectMovesRemaining < 1{
            totalLoses += 1
        }else if currentGame.guessedWord == currentGame.word {
            totalWins += 1
        }else{
            updateUI()
        }
    }
    
    
    func updateUI(){
        let movesRemaining = currentGame.incorrectMovesRemaining
        let image = ("Tree \(movesRemaining < 0 ? 0 : movesRemaining < 8 ? movesRemaining : 7)")
        treeImageView.image = UIImage(named: image)
       updateCorrectWordLabel()
        scoreLabel.text = "Выигрышей - \(totalWins), проигрышей - \(totalLoses)"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
   

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
      let letter = sender.title(for: .normal)!
       currentGame.playerGuessed(letter: Character(letter))
     updateState()
    }
    
}

