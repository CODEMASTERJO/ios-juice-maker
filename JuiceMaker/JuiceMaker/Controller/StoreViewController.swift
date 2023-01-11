//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 조용현 on 2023/01/06.
//

import UIKit

class StoreViewController: UIViewController, FruitRepresentable {
    
    @IBOutlet private var fruitStocks: [UILabel]!
    @IBOutlet private var steppers: [UIStepper]!
    
    var fruitStore: FruitStore?
    var delegate: FruitRepresentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let stocks = fruitStore?.items {
            update(targets: steppers, with: stocks)
            update(targets: fruitStocks, with: stocks)
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        guard let fruit = Fruit(rawValue: sender.tag) else { return }
        fruitStore?.setStock(item: fruit, count: sender.stock)
        // 1개만 업데이트 하는 함수 만들 수 있을까
        if let stocks = fruitStore?.items {
            update(targets: fruitStocks, with: stocks)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.updateStockLabel()
        dismiss(animated: true)
    }
}
