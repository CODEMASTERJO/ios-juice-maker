//
//  FruitStepper.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

// https://stackoverflow.com/questions/40655236/swift-extension-of-a-class-only-when-it-conforms-to-a-specific-protocol
extension FruitStockAssociated where Self:UIStepper {
    var stock: Int {
        get {
            return Int(self.value)
        }
        set {
            self.value = Double(newValue)
        }
    }
}

final class StrawberryStepper: UIStepper, FruitStockAssociated {
    var item: Fruit { .strawberry }
}

final class BananaStepper: UIStepper, FruitStockAssociated {
    var item: Fruit { .banana }
}

final class PineappleStepper: UIStepper, FruitStockAssociated {
    var item: Fruit { .pineapple }
}

final class KiwiStepper: UIStepper, FruitStockAssociated {
    var item: Fruit { .kiwi }
}

final class MangoStepper: UIStepper, FruitStockAssociated {
    var item: Fruit { .mango }
}
