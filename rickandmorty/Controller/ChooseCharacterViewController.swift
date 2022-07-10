//
//  ChooseCharacterViewController.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 30/06/22.
//

import UIKit
import ProgressHUD

class ChooseCharacterViewController: UIViewController {

    let viewModel = ChooseCharacterViewModel()
    var charactersList: [Character]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoader()

        viewModel.loadCharacters(completion: { characters in
            self.charactersList = characters
            self.setupUI()
        })
    }
    
    func setupUI() {
        let scrollView = UIScrollView()
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 0
        
        let viewChoose = ChooseCharacterView()
        viewChoose.charactersList = self.charactersList
        viewChoose.setup()
        viewChoose.translatesAutoresizingMaskIntoConstraints = false
        viewChoose.backgroundColor = .clear

        stackview.addArrangedSubview(viewChoose)
        scrollView.addSubview(stackview)
        
        scrollView.fillSuperView()
        
        stackview.fillView(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: nil
        )
        
        self.dissmisLoader()
    }
}

extension ChooseCharacterViewController: UIViewControllerDelegate {
    func showLoader() {

    }
    
    func dissmisLoader() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
        }
    }
    
    func configureLoader(view: UIView, caption: String = "Loading") {

    }
}
