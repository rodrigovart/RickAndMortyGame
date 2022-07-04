//
//  GameViewModel.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 01/07/22.
//

import UIKit

struct Matches {
    var match: Bool = false
    var character: String = ""
}

struct CharacterSelected {
    var name: String = ""
    var index: Int = 0
    var selected: Bool?
}

class GameViewModel {
    var cardsMock: [String] = [
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
    
    var match = [String]()
    
    var matches = [Matches]()
    
    func initGame() {
        let cardsReversed = Array(cardsMock.reversed())
        let cardsSorted = Array(cardsMock.sorted())
        
        cards.append(contentsOf: cardsReversed)
        cards.append(contentsOf: cardsSorted)
    }
    
    func isMatchCard(character: String) {
        match.append(character)

        if match.count == 2 {
            if match[0] == match[1] {
                matches.append(Matches(match: true, character: character))
            }
            
            match.removeAll()
        }
    }
}
