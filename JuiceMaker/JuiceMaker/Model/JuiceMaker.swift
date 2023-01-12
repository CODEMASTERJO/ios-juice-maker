//
//  JuiceMaker - JuiceMaker.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

struct JuiceMaker<Store: Storing, Product: Makeable> where Store.Item == Product.Ingredient {
    private(set) var fruitStore: Store
    
    mutating func make(juice: Product) throws {
        let ingredients = juice.ingredients
        try self.fruitStore.subtract(pairOfItems: ingredients)
    }
}
