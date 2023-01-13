//
//  FruitLabel.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

extension FruitStockAssociated where Self:UILabel {
    var stock: Int {
        get {
            return Int(self.text ?? "0") ?? 0
        }
        set {
            self.text = String(newValue)
        }
    }
}

final class StrawberryLabel: UILabel, FruitStockAssociated {
    var item: Fruit { .strawberry }
}

final class BananaLabel: UILabel, FruitStockAssociated {
    var item: Fruit { .banana }
}

final class PineappleLabel: UILabel, FruitStockAssociated {
    var item: Fruit { .pineapple }
}

final class KiwiLabel: UILabel, FruitStockAssociated {
    var item: Fruit { .kiwi }
}

final class MangoLabel: UILabel, FruitStockAssociated {
    var item: Fruit { .mango }
}
