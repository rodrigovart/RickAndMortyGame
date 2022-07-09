//
//  CharacterCardView.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 01/07/22.
//

import UIKit

protocol CharacterCardViewDelegate: AnyObject {
    func onCardTap(cell: CharacterCardView, index: Int)
}

class CharacterCardView: UICollectionViewCell {
    
    weak var delegate: CharacterCardViewDelegate?
    public var charactersSelected = CharacterSelected()
    
    lazy var back: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "back")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var card: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setupView(name: String = "back", match: Bool = false) {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        card.image = UIImage(named: name)
        
        addSubview(card)
        card.fillSuperView()
        
        addSubview(back)
        back.fillSuperView()
        
        if match {
            back.removeFromSuperview()
        }
        
        charactersSelected = CharacterSelected(name: name, match: match)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
