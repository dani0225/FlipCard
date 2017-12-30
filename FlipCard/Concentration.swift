//
//  Concentration.swift
//  FlipCard
//
//  Created by Admin on 27/12/2017.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard:Int?
    {
        get
        {
            var foundIndex:Int?
            for index in cards.indices
            {
                if cards[index].isFaceUp
                {
                    if foundIndex == nil
                    {
                        foundIndex = index
                        
                    }
                    else
                    {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set(newValue)
        {
            for index in cards.indices
            {
                cards[index].isFaceUp = (index == newValue)
                
            }
        }
    }
    var countPairs:Int = 0
    
    mutating func chooseCard(at index:Int)
    {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isMatches
        {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index
            {
            
                if cards[matchIndex].identifier == cards[index].identifier
                {
                    countPairs += 1
                    
                    cards[matchIndex].isMatches = true
                    cards[index].isMatches = true
                    
                }
                cards[index].isFaceUp = true
              
            }
            else
            {
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
      
    }
    
    init(numberOfPairOfCards:Int) {
        
        var unShuffelCards: [Card] = []
        
        for _ in 0..<numberOfPairOfCards
        {
        let card = Card()
            unShuffelCards += [card, card]
       
        //cards += [card, card]
    }
        while !unShuffelCards.isEmpty
        {
            let randomIndex = unShuffelCards.count.arc4random
            let card = unShuffelCards.remove(at: randomIndex)
            
            cards.append(card)
        }
        
        
        //TODO: shuffle the cards
        }
    
}
