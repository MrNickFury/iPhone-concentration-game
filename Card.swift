//
//  Card.swift
//  concentration-game
//
//  Created by Nícolas Fabrizzi on 29/03/19.
//  Copyright © 2019 Nícolas Fabrizzi. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false

    var isMatched = false
    
    var isMismatched = false
    
    var isFirstFlip = true
    
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueID() -> Int {
        identifierFactory += 1
        return self.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueID()
    }
    
}
