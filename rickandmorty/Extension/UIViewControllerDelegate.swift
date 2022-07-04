//
//  UIViewControllerDelegate.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 30/06/22.
//

import UIKit

@objc protocol UIViewControllerDelegate {
    @objc optional func showLoader()
    @objc optional func dissmisLoader()
}
