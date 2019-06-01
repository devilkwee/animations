//
//  ViewController.swift
//  ViewControllerTransition(CircularAnimation)
//
//  Created by Thiha Aung on 2019/06/01.
//  Copyright © 2019 Thiha Aung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var openButton: UIButton!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        openButton.layer.cornerRadius = openButton.frame.size.width / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVc = segue.destination as! NextViewController
        nextVc.transitioningDelegate = self
        nextVc.modalPresentationStyle = .custom
    }
}


extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = openButton.center
        transition.circleColor = openButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = openButton.center
        transition.circleColor = openButton.backgroundColor!
        
        return transition
    }
}

