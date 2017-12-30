//
//  ViewController.swift
//  FlipCard
//
//  Created by Admin on 26/12/2017.
//  Copyright © 2017 home. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   lazy var game = Concentration(numberOfPairOfCards: numberOfPairOfCards)
    //you cannot use property observers with lazy
    
    override func viewDidLoad() {
        restartOutlet.isHidden = true
    }
    
    var numberOfPairOfCards:Int
    {
        get
        {
            return (cardButtons.count + 1) / 2
        }
    }
    
    private(set) var flipCount = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
       
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func restartButton(_ sender: UIButton) {
        
        for button in cardButtons
        {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            button.isHidden = false
        }
        game.countPairs = 0
        
        game = Concentration(numberOfPairOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: 0"
        flipCount = 0
        emojii = [:]
        emojiList = ["🤡", "👿", "🎃", "👻","😾","💍"]
        restartOutlet.isHidden = true
    }
    
    @IBOutlet weak var restartOutlet: UIButton!
    
    
    @IBAction func touchCard(_ sender: UIButton) {

        flipCount += 1
    
        if let cardNumber = cardButtons.index(of: sender)
        {
        game.chooseCard(at: cardNumber)
            updateViewFromModel()
         
           
      
        }
        else
        {
            print("chosen card is not in cardButtons")
        }
    }
    
    
    func updateViewFromModel()
    {
        
        if game.countPairs == cardButtons.count / 2
        {
            for button in cardButtons
            {
                button.isHidden = true
            }
            restartOutlet.isHidden = false
        }
        
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
               
                button.setTitle(emoji(for:card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle("", for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                button.backgroundColor = card.isMatches ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                
                
                
            }
        }
        
    }
    
    
    var emojiList = ["🤡", "👿", "🎃", "👻","😾","💍"]
    
    

    var emojii = [Int:String]()
    
    func emoji(for card: Card) -> String
    {
        if emojii[card.identifier] == nil, emojiList.count > 0
        {
            emojii[card.identifier] = emojiList.remove(at: emojiList.count.arc4random)
           
        }
        
       return emojii[card.identifier] ?? "?"
        
        
        }
    
}



extension Int
{
    var arc4random: Int
    { 
        if self > 0
        {
        return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0
        {
           return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else
        {
            return 0
        }
    }
}

