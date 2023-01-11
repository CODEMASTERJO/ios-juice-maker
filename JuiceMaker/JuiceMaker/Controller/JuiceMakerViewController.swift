//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class JuiceMakerViewController: UIViewController, FruitRepresentable {
    @IBOutlet private var fruitStocks: [UILabel]!

    private var fruitStore = FruitStore(defaultStock: 10)
    private var juiceMaker: JuiceMaker<FruitStore, Juice>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        juiceMaker = JuiceMaker(fruitStore: fruitStore)
        updateStockLabel()
    }
    
    @IBAction func ModifyStockButtonTapped(_ sender: UIBarButtonItem) {
        showStoreView()
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        let orderName = sender.currentTitle
        let juiceName = orderName?.replacingOccurrences(of: " 주문", with: "")
        guard let juice = Juice(rawValue: juiceName ?? "") else {
            showAlert(message: "팔 수 없습니다.")
            return
        }
        
        do {
            try juiceMaker.make(juice: juice)
            showAlert(message: "\(juice.rawValue) 나왔습니다! 맛있게 드세요!")
        } catch is JuiceMakerError {
            showFailAlert()
        } catch {
            showAlert(message: "\(error)")
        }
        updateStockLabel()
    }
    
    private func showStoreView() {
        guard let storeNaviVC = storyboard?.instantiateViewController(withIdentifier: "storeNavi") as? UINavigationController else { return }

        storeNaviVC.modalPresentationStyle = .fullScreen
        storeNaviVC.modalTransitionStyle = .coverVertical
        
        guard let storeVC = storeNaviVC.viewControllers.first(where: { $0 is StoreViewController }) as? StoreViewController else { return }
        
        storeVC.fruitStore = fruitStore
        storeVC.delegate = self
        
        present(storeNaviVC, animated: true)
    }
}

//MARK: - Alert 구현
extension JuiceMakerViewController {
    private func showFailAlert() {
        let failAlert = UIAlertController(title: nil,
                                          message: "재고가 모자라요. 재고를 수정할까요?",
                                          preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "예",
                                          style: .default,
                                          handler: { _ in self.showStoreView() })
        let cancelAction = UIAlertAction(title: "아니오",
                                         style: .cancel)
        
        failAlert.addAction(confirmAction)
        failAlert.addAction(cancelAction)
        present(failAlert, animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil,
                                             message: message,
                                             preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인",
                                          style: .default)
        
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}

extension JuiceMakerViewController: FruitRepresentDelegate {
    func updateStockLabel() {
        update(targets: fruitStocks, with: fruitStore.items)
    }
}
