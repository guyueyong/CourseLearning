//
//  Card.swift
//  Concentration
//
//  Created by Hu Yong on 6/18/19.
//  Copyright © 2019 SAP. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    
    init(identifier: Int){
        self.identifier = identifier
    }
    
    static var identifierFactory = 0
    
    static func getUniquelIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init(){
         self.identifier = Card.getUniquelIdentifier()
    }
}
