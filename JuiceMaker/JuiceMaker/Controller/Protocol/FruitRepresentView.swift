//
//  FruitRepresentView.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import Foundation

protocol FruitRepresentViewDelegate {
    func updateStock(with stocks:[Fruit: Int])
}

protocol FruitRepresentView {
    func update(targets: [FruitStockAssociated], with: [Fruit: Int])
}

extension FruitRepresentView {
    func update(targets: [FruitStockAssociated], with stocks: [Fruit: Int]) {
        stocks.forEach { fruit, stock in
            if var target = targets.filter({ component in
                component.item == fruit
            }).first {
                target.stock = stock
            }
        }
    }
}
