//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 조용현 on 2023/01/06.
//

import UIKit

class StoreViewController: UIViewController {
    
    @IBOutlet weak var strawberryStock: UILabel!
    @IBOutlet weak var bananaStock: UILabel!
    @IBOutlet weak var pineappleStock: UILabel!
    @IBOutlet weak var kiwiStock: UILabel!
    @IBOutlet weak var mangoStock: UILabel!
    
    var fruitStore: FruitStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStockValue()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        print(sender.tag)
        
        print(sender.value)
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            guard let vc = self.presentedViewController as? JuiceMakerViewController else { return }
            vc.updateStockValue()
        }
    }
    
    func test() {
        fruitStore?.add(item: .mango, count: 3)
    }

    private func updateStockValue() {
        strawberryStockCount = fruitStore?.items[.strawberry, default: 0] ?? 0
        bananaStockCount = fruitStore?.items[.banana, default: 0] ?? 0
        pineappleStockCount = fruitStore?.items[.pineapple, default: 0] ?? 0
        kiwiStockCount = fruitStore?.items[.kiwi, default: 0] ?? 0
        mangoStockCount = fruitStore?.items[.mango, default: 0] ?? 0
    }
}

extension StoreViewController {
    var strawberryStockCount: Int {
        get {
            return Int(strawberryStock.text ?? "0") ?? 0
        }
        set {
            
            strawberryStock.text = String(newValue)
        }
    }
    var bananaStockCount: Int {
        get {
            return Int(bananaStock.text ?? "0") ?? 0
        }
        set {
            bananaStock.text = String(newValue)
        }
    }
    var pineappleStockCount: Int {
        get {
            return Int(pineappleStock.text ?? "0") ?? 0
        }
        set {
            pineappleStock.text = String(newValue)
        }
    }
    var kiwiStockCount: Int {
        get {
            return Int(kiwiStock.text ?? "0") ?? 0
        }
        set {
            kiwiStock.text = String(newValue)
        }
    }
    var mangoStockCount: Int {
        get {
            return Int(mangoStock.text ?? "0") ?? 0
        }
        set {
            mangoStock.text = String(newValue)
        }
    }
}
