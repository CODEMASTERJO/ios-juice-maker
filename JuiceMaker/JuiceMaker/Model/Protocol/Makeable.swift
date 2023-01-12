//
//  Protocols.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import Foundation

protocol Ingredientable: Hashable { }

protocol Makeable {
    associatedtype Ingredient: Ingredientable
    var ingredients: [Ingredient: Int] { get }
}
