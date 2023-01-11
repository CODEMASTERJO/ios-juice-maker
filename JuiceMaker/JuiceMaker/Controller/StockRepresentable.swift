//
//  FruitAssociated.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

protocol FruitStockRepresentable {
    var item: Fruit? { get }
    var stock: Int { get set }
}

extension IngredientLabel<Fruit>: FruitStockRepresentable {
    var stock: Int {
        get {
            return Int(self.text ?? "0") ?? 0
        }
        set {
            self.text = String(newValue)
        }
    }
}

extension IngredientStepper<Fruit>: FruitStockRepresentable {
    var stock: Int {
        get {
            return Int(self.value)
        }
        set {
            self.value = Double(newValue)
        }
    }
}
