//
//  ViewController.swift
//  concentration-game
//
//  Created by Nícolas Fabrizzi on 28/03/19.
//  Copyright © 2019 Nícolas Fabrizzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /** only initializes when someone needs it, enable us to use cardButtons
     even though it hasnt been initialize yet **/
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
    
    var emojiChoices = [String]()
    
    override func viewDidLoad() {
        view.backgroundColor = game.gameTheme.keys.first![0]
        ponctuationLabel.textColor = game.gameTheme.keys.first![1]
        emojiChoices = game.gameTheme.values.first!
        for i in cardButtons.indices {
            let button = cardButtons[i]
            button.backgroundColor = game.gameTheme.keys.first![1]
        }
    }

    @IBOutlet var cardButtons: Array<UIButton>!
    
    @IBOutlet weak var ponctuationLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            appliesPonctuation(for: cardIndex)
            updateView()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
        sender.setTitleColor(game.gameTheme.keys.first![1], for: UIControl.State.normal)
        ponctuationLabel.textColor = game.gameTheme.keys.first![1]
        view.backgroundColor = game.gameTheme.keys.first!.first!
        emojiChoices = game.gameTheme.values.first!
        for i in cardButtons.indices {
            let button = cardButtons[i]
            button.backgroundColor = game.gameTheme.keys.first![1]
            button.setTitle("", for: UIControl.State.normal)
        }
        updateView()
    }
    
    func appliesPonctuation(for index: Int) {
        let card = game.cards[index]
        let button = cardButtons[index]
        if card.isMatched && button.backgroundColor != #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
            game.totalPoints += 18
        } else if card.isMismatched && !card.isMatched && !card.isFirstFlip {
            game.totalPoints -= 6
        }
        game.cards[index].isFirstFlip = false
    }
    
    func finishGame() {
        if game.cards.allSatisfy({ $0.isMatched == true}) {
            for button in cardButtons {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
            ponctuationLabel.text = "You made \(game.totalPoints) points!"
            return
        }
    }
    
    func updateView() {
        finishGame() // making sure it doesn't has to execute the entire func if the game has already been finished
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                // if it is matched, make it disapear, otherwise, paint it cian
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : game.gameTheme.keys.first![1]
            }
        }
        ponctuationLabel.text = "Total Points: \(game.totalPoints)"
    }
    
    var emoji = [Int:String]()
    
    func getEmoji(for card: Card) -> String {
        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                // remove method returns the removed object before removing it from the array
                emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.getRandomNumber())
            }
        }
        return emoji[card.identifier] ?? "?"
    }
}

extension Int {
    
    func getRandomNumber() -> Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
    
}

