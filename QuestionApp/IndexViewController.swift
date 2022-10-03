//
//  ViewController.swift
//  QuestionApp
//
//  Created by gih96984 on 2022/9/6.
//

import UIKit

class IndexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //viewcontroller to next view, (建立segue,並命名), (選擇觸發元件)button to next page
    @IBAction func toStart(_ sender: UIButton) {
        performSegue(withIdentifier: "toQuestion", sender: nil)
    }
    
    
    
}

