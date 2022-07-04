//
//  ChooseCharacterViewModel.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 30/06/22.
//

import Foundation

class ChooseCharacterViewModel {
    var allCharacters = [Character]()
    
    func loadCharacters(completion: @escaping ([Character]) -> Void) {
        CharactersAPI.shared.loadCharacters(completion: { characters in
            self.allCharacters.append(contentsOf: characters)
            completion(self.allCharacters)
        })
    }
}
