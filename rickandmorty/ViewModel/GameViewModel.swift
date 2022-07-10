//
//  GameViewModel.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 01/07/22.
//

import UIKit

struct CharacterSelected {
    var name: String = ""
    var match: Bool = false
    var index: Int = 0
}

class GameViewModel {
    var cardsChacters: [String] = [
        "beth",
        "jerry",
        "jessica",
        "morty",
        "pessoa-passaro",
        "pickle-rick",
        "rick",
        "summer",
        "meeseeks",
        "scroopy"
    ]
    
    var cards = [String]()
    
    var charactersSelected = [String]()
    
    var charactersMatched: [CharacterSelected] = []
    
    func initGame() {
        cards.removeAll()
        
        let cardsReversed = Array(cardsChacters.reversed())
        let cardsSorted = Array(cardsChacters.sorted())
        
        cards.append(contentsOf: cardsReversed)
        cards.append(contentsOf: cardsSorted)
        
        cards.shuffle()
    }

    func isMatchCard(character: String, match: Bool, index: Int) {
        charactersSelected.append(character)
                
        if charactersSelected.count == 2 {
            if charactersSelected[0] == charactersSelected[1] {
                charactersMatched.append(CharacterSelected(name: character, match: true, index: index))
            }
        }
    }
}
