//
//  FruitLabel.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

protocol FruitLabel: FruitStockAssociated {
    var text: String? { get set }
}

extension FruitLabel {
    var stock: Int {
        get {
            return Int(self.text ?? "0") ?? 0
        }
        set {
            self.text = String(newValue)
        }
    }
}

final class StrawberryLabel: UILabel, FruitLabel {
    var item: Fruit { .strawberry }
}

final class BananaLabel: UILabel, FruitLabel {
    var item: Fruit { .banana }
}

final class PineappleLabel: UILabel, FruitLabel {
    var item: Fruit { .pineapple }
}

final class KiwiLabel: UILabel, FruitLabel {
    var item: Fruit { .kiwi }
}

final class MangoLabel: UILabel, FruitLabel {
    var item: Fruit { .mango }
}
