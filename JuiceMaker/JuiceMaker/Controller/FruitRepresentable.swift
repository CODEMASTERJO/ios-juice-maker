//
//  FruitRepresentable.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import Foundation

protocol FruitRepresentDelegate {
    func updateStockLabel()
}

protocol FruitRepresentable {
    func update(targets: [FruitAssociated], with: [Fruit: Int])
}

extension FruitRepresentable {
    func update(targets: [FruitAssociated], with stocks: [Fruit: Int]) {
        stocks.forEach { fruit, stock in
            if var target = targets.filter({ $0.tag == fruit.rawValue}).first {
                target.stock = stock
            }
        }
    }
}
