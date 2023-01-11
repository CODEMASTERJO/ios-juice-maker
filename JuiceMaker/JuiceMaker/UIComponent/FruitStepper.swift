//
//  FruitStepper.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

class IngredientStepper<Ingredient: Ingredientable>: UIStepper {
    var item: Ingredient? { nil }
}

final class StrawberryStepper: IngredientStepper<Fruit> {
    override var item: Fruit? { .strawberry }
}

final class BananaStepper: IngredientStepper<Fruit> {
    override var item: Fruit? { .banana }
}

final class PineappleStepper: IngredientStepper<Fruit> {
    override var item: Fruit? { .pineapple }
}

final class KiwiStepper: IngredientStepper<Fruit> {
    override var item: Fruit? { .kiwi }
}

final class MangoStepper: IngredientStepper<Fruit> {
    override var item: Fruit? { .mango }
}
