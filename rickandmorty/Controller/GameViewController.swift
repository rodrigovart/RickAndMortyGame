//
//  GameViewController.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 01/07/22.
//

import UIKit

class GameViewController: UIViewController {
    
    var myCollectionView: UICollectionView?
    let viewModel = GameViewModel()
    let cellID = "characterID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.initGame()
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.register(CharacterCardView.self, forCellWithReuseIdentifier: cellID)
        myCollectionView?.backgroundColor = UIColor.white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CharacterCardView else {
            return UICollectionViewCell()
        }
        myCell.setupView(name: viewModel.cards[indexPath.item], index: indexPath.item)
        return myCell
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CharacterCardView {
            cell.sendSubviewToBack(cell.back)
            onCardTap(cell: cell)
        }
    }
}

extension GameViewController: CharacterCardViewDelegate {
    func onCardTap(cell: CharacterCardView) {
        viewModel.isMatchCard(character: cell.charactersSelected.name)
        
        for match in viewModel.matches {
            if cell.charactersSelected.name != match.character {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.myCollectionView?.reloadData()
                }
            } else {
                cell.sendSubviewToBack(cell.back)
            }
        }
    }
}
