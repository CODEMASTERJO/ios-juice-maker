//
//  JuiceMaker - FruitStore.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

final class FruitStore: Storing {
    private(set) var items: [Fruit : Int] = [:]
    
    init(defaultStock count: Int) {
        Fruit.allCases.forEach { add(item: $0, count: count) }
    }
    
    init(pairOfItems: [Fruit: Int]) {
        pairOfItems.forEach { (fruit, count) in
            add(item: fruit, count: count)
        }
    }
    
    func add(item: Fruit, count: Int) {
        items[item, default: 0] += count
    }
    
    private func subtract(item: Fruit, count: Int) -> Bool {
        guard let stock = items[item],
              stock >= count else {
            return false
        }
        
        items.updateValue(stock - count, forKey: item)
        return true
    }
    
    func subtract(pairOfItems neededAmount: [Fruit: Int]) -> Bool{
        guard self.hasEnough(pairOfItems: neededAmount) else { return false }
        
        return neededAmount.allSatisfy({ (fruit, usedAmount) in
            subtract(item: fruit, count: usedAmount)
        })
    }
    
    func setStocks(pairOfItems stocks: [Fruit: Int]) {
        items.merge(stocks) { (_, new) in new }
    }
}
