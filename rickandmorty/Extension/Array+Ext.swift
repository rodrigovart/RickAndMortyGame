//
//  Array+Ext.swift
//  rickandmorty
//
//  Created by Rodrigo Vart on 04/07/22.
//

import Foundation

extension Array {
    //Randomizes the order of the array elements
    mutating func shuffle() {
        for _ in 1...self.count {
            self.sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
