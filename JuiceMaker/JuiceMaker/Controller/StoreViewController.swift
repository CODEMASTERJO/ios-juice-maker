//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 조용현 on 2023/01/06.
//

import UIKit
import Combine

class StoreViewController: UIViewController, FruitRepresentable {
    
    @IBOutlet private var fruitStocks: [UILabel]!
    @IBOutlet private var steppers: [UIStepper]!
    
    var fruitStore: FruitStore?
    private var cancellable: Cancellable?

    init?(coder: NSCoder, fruitStore: FruitStore){
        self.fruitStore = fruitStore
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update(targets: steppers, with: fruitStore?.items ?? [:])
        cancellable = fruitStore?.$items
            .sink() {
                self.update(targets: self.fruitStocks, with: $0)
            }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        guard let fruit = Fruit(rawValue: sender.tag) else { return }
        fruitStore?.setStock(item: fruit, count: sender.stock)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

