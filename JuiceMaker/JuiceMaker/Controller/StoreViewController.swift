//
//  StoreViewController.swift
//  JuiceMaker
//
//  Created by 조용현 on 2023/01/06.
//

import UIKit

protocol UpdateStore {
    func updateStock(name: String)
}

class StoreViewController: UIViewController, UpdateStore {
    var someString: String?
    var stock:[Fruit: Int]?
    var delegate: UpdateStore?
    
    @IBOutlet weak var someStringLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someStringLabel.text = someString
    }
    
    func updateStock(name: String) {
        self.someString = name
    }
    
    @IBAction func touchApply(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// https://stackoverflow.com/questions/67615581/how-to-create-a-custom-uilabel-in-swift-with-a-specific-color
class FrutStockLabel: UILabel {
//    let fruit: Fruit
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    private func setup() {
        self.textColor = .red
    }
}
