//
//  NextViewController.swift
//  ViewControllerTransition(CircularAnimation)
//
//  Created by Thiha Aung on 2019/06/01.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
    }
    

    @IBAction func didTapOnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
