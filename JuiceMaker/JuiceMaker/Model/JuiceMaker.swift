//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

final class JuiceMaker<T:Storing> where T.Element == Fruit {
    private(set) var fruitStore: T
    
    init(fruitStore: T) {
        self.fruitStore = fruitStore
    }
    
    func make(juice: Juice) throws -> Juice {
        let ingredients: [Fruit: Int] = juice.ingredients
        guard fruitStore.hasEnough(pairOfItems: ingredients) else {
            throw JMError.outOfStock
        }
        self.fruitStore.subtract(pairOfItems: ingredients)
        
        return juice
    }
}

