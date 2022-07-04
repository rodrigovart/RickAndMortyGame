//
//  CharactersAPI.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 30/06/22.
//

import UIKit
import Alamofire
import SwiftyJSON

class CharactersAPI {
    public static let shared =  CharactersAPI()
    
    func loadCharacters(completion: @escaping ([Character]) -> Void) {
        AF.request("https://rickandmortyapi.com/api/character/?status=alive&name=").responseJSON { response in
            let json = JSON(response.value ?? "")
            var characters = [Character]()

            for character in json["results"].arrayValue {
                characters.append(Character(id: character["id"].intValue, name: character["name"].stringValue, image: character["image"].stringValue))
            }

            completion(characters)
        }
    }
}
