//
//  ChooseCharacterView.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 30/06/22.
//

import Foundation
import UIKit
import DropDown

protocol ChooseCharacterViewDelegate {
    func chooseCharacter(choose: String)
}

class ChooseCharacterView: UIView {
    
    var charactersList: [Character]?
    var charactersNamesList = [String]()
    
    let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        label.text = "Selecione o"
        return label
    }()
        
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    func setup() {
        let view = UIView()
//        view.addSubview(dropDown)
        
        addSubview(view)
        
        view.fillView(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor
        )
    }
    
    fileprivate func getCharacterListNames() -> [String] {
        if let charactersList = charactersList {
            for character in charactersList {
                charactersNamesList.append(character.name)
            }
        }

        return charactersNamesList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
