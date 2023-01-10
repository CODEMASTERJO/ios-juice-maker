//
//  FruitAssociated.swift
//  JuiceMaker
//
//  Created by sei on 2023/01/11.
//

import UIKit

protocol FruitAssociated {
    var tag: Int { get }
    var stock: Int { get set }
}

extension UILabel: FruitAssociated {
    var stock: Int {
        get {
            return Int(self.text ?? "0") ?? 0
        }
        set {
            self.text = String(newValue)
        }
    }
}

extension UIStepper: FruitAssociated {
    var stock: Int {
        get {
            return Int(self.value)
        }
        set {
            self.value = Double(newValue)
        }
    }
}
