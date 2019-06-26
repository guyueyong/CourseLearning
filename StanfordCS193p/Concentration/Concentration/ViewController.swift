//
//  ViewController.swift
//  Concentration
//
//  Created by  on 18/5/2018.
//  Copyright © 2018 SAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var game : Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCard)
    
    var numberOfPairsOfCard : Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet {
             flipCountLable.text = "Flips: \(flipCount)"
        }
    }
    
    var emojiChoices  =  ["👻","🎃","🐶","🐷","🦆","🐥","🦕","🍎","🍔","🎂","⚽️","🎈","💡","🧰","🏍","⛵️","🎤"]
    var emoji = [Int:String]()
    
    @IBOutlet weak var flipCountLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
   
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else{
            print("chosen card was not in cardButtons")
        }
    }
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor  = UIColor.white
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor  = card.isMatched ? UIColor.black: UIColor.orange
            }
        }
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("flipCard(withEmoji:\(emoji))")
       
        if button.currentTitle == emoji {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor  = UIColor.orange
        }
        else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor  = UIColor.white
        }
    }
    
    func emoji(for card: Card) ->String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}

