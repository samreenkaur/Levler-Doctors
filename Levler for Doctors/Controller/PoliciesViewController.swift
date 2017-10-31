//
//  PoliciesViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 15/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit

class PoliciesViewController: UIViewController {

    @IBOutlet weak var loadingbt: UILabel!
    @IBOutlet weak var webViewPage: UIWebView!
    @IBOutlet weak var contentlabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    
    
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    func webViewDidStartLoad(_ : UIWebView) {
        //  loadSpinner.startAnimating()
        showActivityIndicator()
    }
    
    func webViewDidFinishLoad(_ : UIWebView) {
        //  loadSpinner.stopAnimating()
        hideActivityIndicator()
    }
    
    override func viewDidLoad() {
        //
        
        super.viewDidLoad()
        btn.isHidden = true
        //    showActivityIndicator()
        webViewDidStartLoad(webViewPage)
        let url = NSURL (string: "http://app.levler.co/privacy_policy");
        let requestObj = NSURLRequest(url: url! as URL);
        webViewPage.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        webViewPage.loadRequest(requestObj as URLRequest);
        webViewDidFinishLoad(webViewPage)
        
        //   hideActivityIndicator()
        /* if let url = URL(string: "https://app.levler.co/privacy_policy") {
         do {
         let contents = try String(contentsOf: url)
         print(contents)
         self.contentlabel.text = contents
         } catch {
         // contents could not be loaded
         }
         } else {
         // the URL was bad!
         }*/
        
        //  contentlabel.sizeToFit()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = UIColor.lightGray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
    
}

