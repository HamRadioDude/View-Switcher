//
//  SwitchingViewController.swift
//  View Switcher
//
//  Created by student on 2/24/19.
//  Copyright © 2019 Sean Klechak. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {

    private var blueViewController: BlueViewController!
    private var yellowViewController: YellowViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue") as? BlueViewController
        blueViewController.view.frame = view.frame
        switchViewController(from: nil, to: blueViewController) // helper method
        
        
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if blueViewController != nil && blueViewController!.view.superview == nil{
            blueViewController = nil
        }
        if yellowViewController!.view.superview == nil {
            yellowViewController = nil
        }
    }
    

   

    @IBAction func switchViews(sender:UIBarButtonItem){
        // Create the new view controller if required
        if yellowViewController?.view.superview == nil {
            if yellowViewController == nil {
                yellowViewController = storyboard?.instantiateViewController(withIdentifier: "Yellow") as? YellowViewController
                }
            } else if blueViewController?.view.superview == nil {
                if blueViewController == nil {
                    blueViewController = storyboard?.instantiateViewController(withIdentifier: "Blue") as? BlueViewController
//                } else {
//                    blueViewController.view.frame = view.frame
//                    switchViewController(from: yellowViewController, to: blueViewController)
                    }
                }
            UIView.beginAnimations("View Flip", context: nil)
            UIView.setAnimationDuration(0.4)
            UIView.setAnimationCurve(.easeInOut)
        
            // switch view controllers
            if blueViewController != nil
                && blueViewController!.view.superview != nil {
                UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
                
                yellowViewController.view.frame = view.frame
                switchViewController(from: blueViewController, to: yellowViewController)
            } else {
                UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
                blueViewController.view.frame = view.frame
                switchViewController(from: yellowViewController, to: blueViewController)
            }
        UIView.commitAnimations()
    }
    
    private func switchViewController(from fromVC:UIViewController?, to toVC:UIViewController?) {
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
            
        }
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at:0)
            toVC!.didMove(toParent: self)
        }
    }

}
