//
//  Card.swift
//  FlipCard
//
//  Created by Admin on 27/12/2017.
//  Copyright © 2017 home. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatches = false
    var identifier:Int
    
   private static var identifierFactory = 0
    
   private static func getUniqueIdentifier() -> Int
    {
        identifierFactory += 1
        
        return identifierFactory
    }
    
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}



