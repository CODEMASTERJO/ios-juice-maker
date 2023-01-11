//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 조용현 on 2023/01/06.
//

import UIKit

class StoreViewController: UIViewController, FruitRepresentView {
    @IBOutlet private var fruitStocks: [UILabel]!
    @IBOutlet private var steppers: [UIStepper]!
    
    var fruitStore: FruitStore?
    var delegate: FruitRepresentViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let stocks = fruitStore?.items,
        let fruitSteppers = steppers as? [FruitStockRepresentable],
        let fruitStockLabels = fruitStocks as? [FruitStockRepresentable] {
            update(targets: fruitSteppers, with: stocks)
            update(targets: fruitStockLabels, with: stocks)
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        guard let sender = sender as? FruitStockRepresentable,
              let fruit = sender.item else { return }
        updateLabel(of: fruit, value: sender.stock)
        fruitStore?.setStock(item: fruit, count: sender.stock)
    }
        
    func updateLabel(of item: Fruit, value: Int) {
        guard let labels = fruitStocks as? [FruitStockRepresentable],
              var targetLabel = labels.filter({ $0.item == item }).first else { return }
        targetLabel.stock = value
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        let newStock = parseModifiedStock()
        delegate?.updateStock(with: newStock)
        dismiss(animated: true)
    }
}

extension StoreViewController {
    private func parseModifiedStock() -> [Fruit: Int] {
        guard let steppers = steppers as? [FruitStockRepresentable] else { return [:] }
        let newStock = steppers.reduce(into: [Fruit:Int]()) { partialResult, stepper in
            guard let item = stepper.item else { return }
            partialResult[item] = stepper.stock
        }
        return newStock
    }
}
