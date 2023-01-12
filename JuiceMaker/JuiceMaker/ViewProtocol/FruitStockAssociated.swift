//
//  FruitStockAssociated.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

protocol FruitStockAssociated {
    var item: Fruit { get }
    var stock: Int { get set }
}
