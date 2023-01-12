//
//  FruitJuiceButton.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/12.
//

import UIKit

protocol FruitJuiceButton {
    var juice: FruitJuice { get }
    var ingredients: [Fruit: Int] { get }
}

extension FruitJuiceButton {
    var ingredients: [Fruit: Int] {
        self.juice.ingredients
    }
}

final class StrawberryJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .strawberryJuice }
}

final class BananaJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .bananaJuice }
}

final class KiwiJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .kiwiJuice }
}

final class PineappleJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .pineappleJuice }
}

final class DdalbaJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .ddalbaJuice }
}

final class MangoJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .mangoJuice }
}

final class MangkiJuiceButton: UIButton, FruitJuiceButton {
    var juice: FruitJuice { .mangkiJuice }
}

