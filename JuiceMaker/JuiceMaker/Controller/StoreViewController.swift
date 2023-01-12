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
           let fruitSteppers = steppers as? [FruitStockAssociated],
           let fruitStockLabels = fruitStocks as? [FruitStockAssociated] {
            update(targets: fruitSteppers, with: stocks)
            update(targets: fruitStockLabels, with: stocks)
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        guard let sender = sender as? FruitStockAssociated else { return }
        updateLabel(of: sender.item, value: sender.stock)
    }
    
    func updateLabel(of item: Fruit, value: Int) {
        guard let labels = fruitStocks as? [FruitStockAssociated],
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
        guard let steppers = steppers as? [FruitStockAssociated] else { return [:] }
        let newStock = steppers.reduce(into: [Fruit:Int]()) { partialResult, stepper in
            partialResult[stepper.item] = stepper.stock
        }
        return newStock
    }
}
