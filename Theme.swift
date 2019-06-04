//
//  Theme.swift
//  concentration-game
//
//  Created by Nícolas Fabrizzi on 05/04/19.
//  Copyright © 2019 Nícolas Fabrizzi. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    
    var themesCollection: Array<Array<String>>
    
    var colorsCollection: Array<Array<UIColor>>
    
    init() {
        
        colorsCollection = [
            [UIColor.black, UIColor.yellow],
            [UIColor.green, UIColor.red],
            [UIColor.orange, UIColor.blue],
            [UIColor.magenta, UIColor.black],
            [UIColor.black, UIColor.purple],
            [UIColor.blue, UIColor.brown]
        ]
        
        themesCollection = [
            ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑"],
            ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇"],
            ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
            ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🥏", "🥊"],
            ["⌚️", "📱", "💻", "🕹", "💿", "🖨", "🖥", "💾"],
            ["🇧🇷", "🇦🇺", "🇯🇵", "🇺🇸", "🇪🇸", "🇵🇹", "🇨🇭", "🇮🇱"]
        ]
    }
    
    func chooseARandomTheme() -> [Array<UIColor>:Array<String>]{
        let randomNumber = Int(arc4random_uniform(UInt32(themesCollection.count)))
        let chosenTheme = themesCollection[randomNumber]
        let chosenColor = colorsCollection[randomNumber]
        return [chosenColor:chosenTheme]
    }
}
