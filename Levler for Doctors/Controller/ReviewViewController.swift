//
//  ReviewViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 15/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var facebookVC: UIView!
    @IBOutlet weak var googleVC: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func backbutton(_ sender: Any) {
        
    }
    @IBAction func valueChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            googleVC.isHidden = false
            facebookVC.isHidden = true
        case 1:
            facebookVC.isHidden = false
            googleVC.isHidden = true
        default:
            break;
        }
    }
    
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        print(gesture.direction)
        
        switch gesture.direction {
            
        case UISwipeGestureRecognizerDirection.left :
            segmentedControl.selectedSegmentIndex = 1
            
            facebookVC.isHidden = false
            googleVC.isHidden = true
            print("swipe left")
        case UISwipeGestureRecognizerDirection.right:
            segmentedControl.selectedSegmentIndex = 0
            
            googleVC.isHidden = false
            facebookVC.isHidden = true
            print("swipe right")
            
        default:
            print("hello")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
        segmentedControl.selectedSegmentIndex = 0
        googleVC.isHidden = false
        facebookVC.isHidden = true
        
        self.navigationItem.titleView = segmentedControl
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.handleSwipe(gesture:)))
            
            gesture.direction = direction
            self.view?.addGestureRecognizer(gesture)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

