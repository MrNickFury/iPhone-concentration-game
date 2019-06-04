//
//  Concentration.swift
//  concentration-game
//
//  Created by Nícolas Fabrizzi on 29/03/19.
//  Copyright © 2019 Nícolas Fabrizzi. All rights reserved.
//

import Foundation
import UIKit

class Concentration {
    
    var cards = [Card]()
    
    var gameTheme = [Array<UIColor>:Array<String>]()
    
    var theOnlyOneFacedUpCardIndex: Int?
    
    var totalPoints: Int
    
    init(numberOfPairsOfCards: Int) {
        cards.removeAll()
        let theme = Theme()
        self.gameTheme = theme.chooseARandomTheme()
        self.totalPoints = 0
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let faceUpCard = theOnlyOneFacedUpCardIndex {
                if faceUpCard != index {
                    if cards[faceUpCard].identifier == cards[index].identifier {
                        cards[faceUpCard].isMatched = true
                        cards[index].isMatched = true
                    } else {
                        cards[faceUpCard].isMismatched = true
                        cards[index].isMismatched = true
                    }
                    cards[index].isFaceUp = true
                    theOnlyOneFacedUpCardIndex = nil // there's gonna be two faced up cards
                }
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                theOnlyOneFacedUpCardIndex = index
            }
        }
    }
    
}
