//
//  FruitRepresentable.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import Foundation

protocol FruitRepresentViewDelegate {
    func updateStock(with stocks:[Fruit: Int])
}

protocol FruitRepresentView {
    func update(targets: [FruitStockRepresentable], with: [Fruit: Int])
}

extension FruitRepresentView {
    func update(targets: [FruitStockRepresentable], with stocks: [Fruit: Int]) {
        stocks.forEach { fruit, stock in
            if var target = targets.filter({
                $0.item != nil && $0.item == Optional(fruit)
            }).first {
                target.stock = stock
            }
        }
    }
}
