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
