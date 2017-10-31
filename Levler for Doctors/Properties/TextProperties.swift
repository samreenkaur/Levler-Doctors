//
//  TextProperties.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import Foundation
import UIKit
private var maxLengths = [UITextField: Int]()
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
       // doneToolbar.backgroundColor = UIColor.gray
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension UITextView{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        doneToolbar.tintColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        // doneToolbar.backgroundColor = UIColor.gray
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
  //  var iskeypadOn = true
  /*  func keyboardOn()
    {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
       // if isKeypadOn {
        
        UIView.init(frame: CGRect(x: 0, y: -100, width: frame.height, height: frame.height))
          //  UIView.frame.origin.y -= 100
       //     isKeypadOn = false
     //   }
        
        
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
     //   if !isKeypadOn{
        UIView.init(frame: CGRect(x: 0, y: 100, width: frame.height, height: frame.height))
        
           // UIView.frame.origin.y += 100
     //       isKeypadOn = true
     //   }
        
    }*/
    
}
extension String
{
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    
    /*  func underlined(){
     let border = CALayer()
     let width = CGFloat(1.0)
     border.borderColor = UIColor.lightGray.cgColor
     border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
     border.borderWidth = width
     //  border.borderColor = UIColor(red: 96/255, green: 189/255, blue: 106/255, alpha: 1.0).cgColor
     self.layer.addSublayer(border)
     self.layer.masksToBounds = true
     }
     func underlinedColor(){
     let border = CALayer()
     let width = CGFloat(1.0)
     border.borderColor = UIColor.lightGray.cgColor
     border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
     border.borderWidth = width
     border.borderColor = UIColor(red: 96/255, green: 189/255, blue: 106/255, alpha: 1.0).cgColor
     self.layer.addSublayer(border)
     self.layer.masksToBounds = true
     }*/
}

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}




/*class MaxLengthTextField: UITextField, UITextFieldDelegate {
 
 private var characterLimit: Int?
 
 
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 delegate = self
 }
 
 @IBInspectable var maxLength: Int {
 get {
 guard let length = characterLimit else {
 return Int.max
 }
 return length
 }
 set {
 characterLimit = newValue
 }
 }
 
 func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
 guard string.characters.count > 0 else {
 return true
 }
 
 let currentText = textField.text ?? ""
 let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
 
 // 1. Here's the first change...
 return allowedIntoTextField(text: prospectiveText)
 }
 
 // 2. ...and here's the second!
 func allowedIntoTextField(text: String) -> Bool {
 return text.characters.count <= maxLength
 }
 
 }
 
 */
extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" :
                "\(minute)" + " " + "minutes ago"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" :
                "\(second)" + " " + "seconds ago"
        } else {
            return ""
            
        }
        
    }
}



