//
//  Game.swift
//  ApplePie
//
//  Created by marinapolyakova on 16.03.2023.
//


struct Game {
    var word : String
    var incorrectMovesRemaining: Int
    
   fileprivate var guessedLetters = [Character]() //буквы, которые пользователь уже нажал
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord : String{
        var wordToShow = ""
        for letter in word{
            if guessedLetters.contains(letter.lowercased()) || letter == "-" || letter == " " {
                wordToShow += String(letter)
            }else{
                wordToShow += "_"
                
            }
  
        }
        return wordToShow
    }
    
   mutating func playerGuessed(letter: Character){
       let lowercasedLetter = Character(letter.lowercased())
       guessedLetters.append(lowercasedLetter)
       if !word.lowercased().contains(lowercasedLetter) {
           incorrectMovesRemaining -= 1
       }
      
    }
}
