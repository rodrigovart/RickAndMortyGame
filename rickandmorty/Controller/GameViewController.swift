//
//  GameViewController.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 01/07/22.
//

import ProgressHUD
import SCLAlertView

class GameViewController: UIViewController {
    
    public static let shared = GameViewController()
    var collectionView: UICollectionView?
    let viewModel = GameViewModel()
    let cellID = "characterID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoader()
        
        viewModel.initGame()
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView?.register(CharacterCardView.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        view.addSubview(collectionView ?? UICollectionView())
        
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(reload))
        navigationItem.rightBarButtonItem = button
        
        dissmisLoader()
    }
    
    @objc func reload() {
        viewModel.charactersMatched.removeAll()
        viewModel.cards.removeAll()
        viewModel.initGame()
        collectionView?.reloadData()
    }
    
    func showWinAlert() {
        let alertView = SCLAlertView()
        alertView.addButton("Recomeçar", target: self, selector: #selector(reload))
        alertView.showSuccess("Parabéns", subTitle: "O jogo terminou!")
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
        
        let card = viewModel.cards[indexPath.item]
        
        viewModel.charactersSelected.removeAll()
        
        myCell.setupView(name: viewModel.cards[indexPath.item])

        viewModel.charactersMatched.forEach { character in
            if character.name == card, character.match {
                myCell.sendSubviewToBack(myCell.back)
            }
        }

        return myCell
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CharacterCardView {
            cell.sendSubviewToBack(cell.back)
            cell.isSelected.toggle()
            onCardTap(cell: cell, index: indexPath.item)
        }
    }
}

extension GameViewController: CharacterCardViewDelegate {
    func onCardTap(cell: CharacterCardView, index: Int) {
       viewModel.isMatchCard(character: cell.charactersSelected.name, match: cell.charactersSelected.match, index: index)
        
        if viewModel.charactersSelected.count == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if self.viewModel.winGame() {
                    self.showWinAlert()
                    return
                }
                self.collectionView?.reloadData()
            }
        }
    }
}

extension GameViewController: UIViewControllerDelegate {
    func showLoader() {
        ProgressHUD.show("Loading")
    }
    
    func dissmisLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ProgressHUD.dismiss()
        }
    }
}
