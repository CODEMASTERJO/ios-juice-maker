//
//  FruitLabel.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

class IngredientLabel<Ingredient: Ingredientable>: UILabel {
    var item: Ingredient? { nil }
}

final class StrawberryLabel: IngredientLabel<Fruit> {
    override var item: Fruit? { .strawberry }
}

final class BananaLabel: IngredientLabel<Fruit> {
    override var item: Fruit? { .banana }
}

final class PineappleLabel: IngredientLabel<Fruit> {
    override var item: Fruit? { .pineapple }
}

final class KiwiLabel: IngredientLabel<Fruit> {
    override var item: Fruit? { .kiwi }
}

final class MangoLabel: IngredientLabel<Fruit> {
    override var item: Fruit? { .mango }
}
