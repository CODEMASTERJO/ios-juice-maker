//
//  FruitStepper.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

protocol FruitStepper: FruitStockAssociated {
    var value: Double { get set }
}

extension FruitStepper {
    var stock: Int {
        get {
            return Int(self.value)
        }
        set {
            self.value = Double(newValue)
        }
    }
}

final class StrawberryStepper: UIStepper, FruitStepper {
    var item: Fruit { .strawberry }
}

final class BananaStepper: UIStepper, FruitStepper {
    var item: Fruit { .banana }
}

final class PineappleStepper: UIStepper, FruitStepper {
    var item: Fruit { .pineapple }
}

final class KiwiStepper: UIStepper, FruitStepper {
    var item: Fruit { .kiwi }
}

final class MangoStepper: UIStepper, FruitStepper {
    var item: Fruit { .mango }
}
