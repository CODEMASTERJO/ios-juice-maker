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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        let orderName = sender.currentTitle
        let juiceName = orderName?.replacingOccurrences(of: " 주문", with: "")
        guard let juice = Juice(rawValue: juiceName ?? "") else {
            print("팔 수 없음")
            return
        }
        do {
            let juice = try juiceMaker.make(juice: juice)
            alert(alertType: .done(juice))
        } catch {
            if let error = error as? JuiceMakerError {
                alert(alertType: .juiceMakerError(error))
            } else {
                print(error)
            }
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
        case juiceMakerError(JuiceMakerError)
        
        static let title = "알림"
        
        var message: String {
            switch self {
            case .done(let juice):
                return "\(juice.rawValue) 나왔습니다! 맛있게 드세요!"
            case .juiceMakerError(let error):
                return error.helpMessage
            }
        }
        
        var actions: [UIAlertAction] {
            switch self {
            case .done:
                return [
                    UIAlertAction(title: "맛있게 먹기", style: UIAlertAction.Style.default)
                ]
            case .juiceMakerError:
                return [
                    // action이 3개라면 cancel은 제일 아래,
                    // action이 2개라면 cancel은 왼쪽,
                    // cancel은 딱 1개만 존재해야. 그렇지 않으면 런타임에러,
                    UIAlertAction(title: "아니요", style: UIAlertAction.Style.cancel, handler: nil),
                    UIAlertAction(title: "예", style: UIAlertAction.Style.default) { action in
                        print(action)
                    }
                ]
            }
        }
    }
    
    func alert(alertType: Alert) {
        let alert = UIAlertController(title: Alert.title, message: alertType.message, preferredStyle: UIAlertController.Style.alert)
        
        for action in alertType.actions {
            alert.addAction(action)
        }
        
        //메시지 창 컨트롤러를 표시
        self.present(alert, animated: true)
    }
}
