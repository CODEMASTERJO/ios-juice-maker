//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

final class FruitStore: Storing {
    private(set) var items: [Fruit : Int] = [:]
    
    init(defaultStock count: Int) {
        for fruit in Fruit.allCases {
            add(item: fruit, count: count)
        }
    }
    
    init(pairOfItems: [Fruit: Int]) {
        for (fruit, count) in pairOfItems {
            add(item: fruit, count: count)
        }
    }
    
    func add(item: Fruit, count: Int) {
        items[item, default: 0] += count
    }
    
    private func subtract(item: Fruit, count: Int) throws {
        items[item]? -= count
    }
    
    func subtract(pairOfItems stocks: [Fruit: Int]) throws {
        guard self.hasEnough(pairOfItems: stocks) else {
            throw JuiceMakerError.outOfStock
        }
        for (fruit, usedAmount) in stocks {
            try subtract(item: fruit, count: usedAmount)
        }
    }
    
    func setStocks(pairOfItems stocks:[Fruit: Int]) {
        stocks.forEach { fruit, stock in
            items[fruit] = stock
        }
    }
}
