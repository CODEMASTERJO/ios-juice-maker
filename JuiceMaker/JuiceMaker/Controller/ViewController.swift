//
//  JuiceMaker - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var strawberryStock: UILabel!
    @IBOutlet weak var bananaStock: UILabel!
    @IBOutlet weak var pineappleStock: UILabel!
    @IBOutlet weak var kiwiStock: UILabel!
    @IBOutlet weak var mangoStock: UILabel!
    
    var fruitLabelFruitMap: [UILabel: Fruit]!
    var fruitStore = FruitStore(defaultStock: 20)
    var juiceMaker: JuiceMaker<FruitStore>!
    var updateStoreDelegate: UpdateStore?
    
    typealias ActionHandler = (()->Void)?
//    var alertHandlers: [Alert: [UIAlertAction.Style: ActionHandler]]?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        alertHandlers = [
//            .done(juice): [.default: nil],
//           .outOfStockError: [
//               .cancel: nil,
//               .default: self.showStoreView
//           ]
//       ]
        juiceMaker = JuiceMaker(fruitStore: fruitStore)
        
        fruitLabelFruitMap = [
            strawberryStock: .strawberry,
            bananaStock: .banana,
            pineappleStock: .pineapple,
            kiwiStock: .kiwi,
            mangoStock: .mango
        ]
        updateStockValue()
    }
    
    private func parseJuiceName(orderName: String?) -> String? {
        return orderName?.replacingOccurrences(of: " 주문", with: "")
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        let juiceName = parseJuiceName(orderName: sender.currentTitle)
        guard let juice = Juice(rawValue: juiceName ?? "") else {
            print("팔 수 없음")
            return
        }
        do {
            let juice = try juiceMaker.make(juice: juice)
            alert(alertType: .done(juice))
        } catch _ as JuiceMakerError  {
            alert(alertType: .outOfStockError)
        } catch {
            print(error)
        }
        updateStockValue()
    }
    
    func updateStockValue() {
        for (label, fruit) in fruitLabelFruitMap {
            label.text = String(fruitStore.items[fruit, default: 0])
        }
    }
}

//MARK: - alert
extension ViewController {
    enum Alert {
        case done(Juice)
        case outOfStockError
        
        static let title = "알림"
        
        var message: String {
            switch self {
            case .done(let juice):
                return "\(juice.rawValue) 나왔습니다! 맛있게 드세요!"
            case .outOfStockError:
                return "재료가 모자라요. 재고를 수정할까요?"
            }
        }
        
        func actions(ch completeHandler: (()->Void)? = nil) -> [UIAlertAction] {
            switch self {
            case .done:
                return [
                    UIAlertAction(title: "맛있게 먹기", style: UIAlertAction.Style.default)
                ]
            case .outOfStockError:
                return [
                    UIAlertAction(title: "아니요", style: UIAlertAction.Style.cancel),
                    UIAlertAction(title: "예", style: UIAlertAction.Style.default) { _ in
                        completeHandler?()
                    }
                ]
            }
        }
    }
    
    func alert(alertType: Alert) {
        let alert = UIAlertController(title: Alert.title, message: alertType.message, preferredStyle: UIAlertController.Style.alert)
        
        for action in alertType.actions(ch: self.showStoreView) {
            alert.addAction(action)
        }
        
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: true)
    }
    
    func showStoreView() {
        guard let storeNaviVC = self.storyboard?.instantiateViewController(identifier: "StoreViewNaviController") as? UINavigationController else {
            return
        }
        storeNaviVC.modalTransitionStyle = .coverVertical
        storeNaviVC.modalPresentationStyle = .currentContext
        
        if let targetVC = storeNaviVC.viewControllers.first(where: { $0 is StoreViewController }) as? StoreViewController {
            targetVC.someString = "haha"
//            self.updateStoreDelegate?.updateStock(name: "haha")
        }
        
        self.present(storeNaviVC, animated: true)
    }
    
}

//
//extension ViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showStoreViewSegue" {
//            let storeVC = segue.destination as? StoreViewController
//            storeVC.someString = "전달 텍스트"
//        }
//    }
//}
