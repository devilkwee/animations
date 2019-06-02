//
//  SecondViewController.swift
//  CollectionViewDemo
//
//  Created by Thiha Aung on 2019/05/26.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didTapOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
