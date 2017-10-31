//
//  CreateAppointmentViewController.swift
//  Levler for Doctors
//
//  Created by Mohak on 14/10/17.
//  Copyright © 2017 Mohak. All rights reserved.
//

import UIKit
import CountryPicker
import FSCalendar
import Alamofire
import TextFieldEffects

class CreateAppointmentViewController: UIViewController, CountryPickerDelegate, UITextViewDelegate {
    
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    var loadingView: UIView = UIView()
    
    
    @IBOutlet var theScrollview: UIScrollView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var countryCodePICKER: CountryPicker!
    @IBOutlet weak var codeButtonValue: UIButton!
    
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var calenderShow: UIView!
    @IBOutlet weak var calendr: FSCalendar!
    
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var ageTextFeild: HoshiTextField!
    
    @IBOutlet weak var genderSelect: UISegmentedControl!
    @IBOutlet weak var selectDateBt: UIButton!
    @IBOutlet weak var dateTextField: HoshiTextField!
    @IBOutlet weak var timeTextField: HoshiTextField!
    
    @IBOutlet weak var contactTextField: HoshiTextField!
    
    @IBOutlet weak var DescriptionTV: UITextView!
    
    @IBOutlet weak var descLine: HoshiTextField!
    
    @IBOutlet weak var Submit: UIButton!
    
    @IBAction func nameTF(_ sender: UITextField) {
        codeText()
        datePicker.isHidden = true
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true
        calenderShow.isHidden = true
        Submit.isHidden = false
        //keyboardOn()
        
    }
    
    @IBAction func dateBt(_ sender: Any) {
        codeText()
        //datePicker.isHidden = false
        calendarView.isHidden = false
        selectDateBt.isHidden = false
        calendr.isHidden = false
        Submit.isHidden = false

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.calendarView.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        }, completion:nil)
        calendarView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true
        dateTextField.text = "\(String(describing: calendr.today))"
        let d = calendr.selectedDate
        dateTextField.text = "\(String(describing: d))"
        
        /*let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "dd-MM-yyyy"
         let strDate = dateFormatter.string(from: datePicker.date)
         dateTextField.text = "\(strDate)"
         //  calendr.didChangeValue(forKey: calendr.selectedDate)
         */
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: calendr.today!)
        dateTextField.text = "\(strDate)"
        
        if ((calendr.selectedDate?.compare(calendr.today!)) != nil)
        {
            let chgDate = dateFormatter.string(from: calendr.selectedDate!)
            dateTextField.text = "\(chgDate)"
            print("!")
            print(chgDate)
        }
        else
        {
            dateTextField.text = "\(strDate)"
            
        }
        print("2    \(String(describing: calendr.selectedDate))")
        
        // calendr.target(forAction: #selector(dateChanged), withSender: FSCalendarDelegate.self )
        //calendr.target(forAction: #selector(dateChanged), withSender: FSCalendar.didChangeValue(forKey: "\(calendr)"))
        //  datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        // print("This Worked")
    }
    @objc func dateChanged(sender: FSCalendar) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = formatter.string(from: calendr.selectedDate!)
        print("3    \(String(describing: calendr.selectedDate))")
        
    }
    @IBAction func timeBt(_ sender: Any) {
        codeText()
        calenderShow.isHidden = true
        
        datePicker.isHidden = true
        timePicker.isHidden = false
        countryCodePICKER.isHidden = true
        Submit.isHidden = true

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.timePicker.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        }, completion:nil)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: timePicker.date)
        timeTextField.text = "\(strDate)"
        timePicker.addTarget(self, action: #selector(timePickerChanged(sender:)), for: .valueChanged)
        print("This Worked")
        
        
    }
    
    
    @IBAction func dateEditing(_ sender: Any) {
        datePicker.isHidden = false
        timePicker.isHidden = true
        
    }
    
    @objc func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = formatter.string(from: sender.date)
    }
    
    @objc func timePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timeTextField.text = formatter.string(from: sender.date)
    }
    
    @IBAction func timeEditing(_ sender: Any) {
        datePicker.isHidden = true
        timePicker.isHidden = false
        calenderShow.isHidden = true
        Submit.isHidden = false

    }
    
    @IBAction func selectDate(_ sender: Any) {
        calendarView.isHidden = true
        selectDateBt.isHidden = true
        calendr.isHidden = true
        Submit.isHidden = false

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: calendr.today!)
        dateTextField.text = "\(strDate)"
        if ((calendr.selectedDate?.compare(calendr.today!)) != nil)
        {
            let chgDate = dateFormatter.string(from: calendr.selectedDate!)
            dateTextField.text = "\(chgDate)"
            print("!")
            print(chgDate)
        }
        else
        {
            dateTextField.text = "\(strDate)"
            
        }
        print("2    \(String(describing: calendr.selectedDate))")
        
    }
    
     var codeLabel = ""
    @IBAction func codeBt(_ sender: Any) {
       // countryCodePICKER.isHidden = false
        if (!isOpen)
        {
            datePicker.isHidden = true
            timePicker.isHidden = true
            calenderShow.isHidden = true
            Submit.isHidden = true

            codeLabel = codeButtonValue.currentTitle!
            let codedown = codeLabel.split(separator: "▾", maxSplits: 2, omittingEmptySubsequences: true)
            
            codeButtonValue.setTitle("\(codedown[0])▴", for: .normal)
            isOpen = true
            countryCodePICKER.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.countryCodePICKER.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            }, completion:nil)
            
            let locale = Locale.current
            let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String?
            //init Picker
            countryCodePICKER.countryPickerDelegate = self
            countryCodePICKER.showPhoneNumbers = true
            countryCodePICKER.setCountry(code!)
            
        }
        else if isOpen {
            datePicker.isHidden = true
            timePicker.isHidden = true
            Submit.isHidden = false

            codeLabel = codeButtonValue.currentTitle!
            let codeup = codeLabel.split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
         
            codeButtonValue.setTitle("\(codeup[0])▾", for: .normal)
         
            isOpen = false
            countryCodePICKER.isHidden = true
            
        }
    }
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        
        codeButtonValue.setTitle("\(phoneCode)▴", for: .normal)
    }
    func codeText(){
        if isOpen {
            datePicker.isHidden = true
            timePicker.isHidden = true
            calenderShow.isHidden = true
            Submit.isHidden = false

            codeLabel = codeButtonValue.currentTitle!
            let codeup = codeLabel.split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
            codeButtonValue.setTitle("\(codeup[0])▾", for: .normal)
            isOpen = false
            countryCodePICKER.isHidden = true

        }
    }
        
   
    @IBAction func contactTF(_ sender: UITextField) {
        codeText()
        calenderShow.isHidden = true
        Submit.isHidden = false

        datePicker.isHidden = true
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true


    }
    
    @IBAction func createAppt(_ sender: Any) {
        
        if nameTextField.text == ""
        {
            nameTextField.borderInactiveColor = UIColor.red
            alertmsg()
        }
        if ageTextFeild.text! == ""
        {
            ageTextFeild.borderInactiveColor = UIColor.red
            alertmsg()
        }
        if ageTextFeild.text == "0" || ageTextFeild.text == "00" || ageTextFeild.text == "000"
        {
            ageTextFeild.borderInactiveColor = UIColor.red
            let alert = UIAlertController(title: "Missing", message: "Age must be greater than zero.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        if dateTextField.text == ""
        {
            dateTextField.borderInactiveColor = UIColor.red
            alertmsg()
        }
        if timeTextField.text == ""
        {
            timeTextField.borderInactiveColor = UIColor.red
            alertmsg()
        }
        if contactTextField.text! == ""
        {
            contactTextField.borderInactiveColor = UIColor.red
            alertmsg()
        }
            if (contactTextField.text?.characters.count)!<10
        {
           contactTextField.borderInactiveColor = UIColor.red
            let alert = UIAlertController(title: "Missing", message: "Contact must contain 10 digits.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
       if DescriptionTV.text == ""
       {
        descLine.borderInactiveColor = UIColor.red
        alertmsg()
       }
        else{
             nameTextField.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
            ageTextFeild.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
            dateTextField.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
            timeTextField.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        contactTextField.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        descLine.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)
        createAppointment()
        }
    }
    func alertmsg(){
        let alert = UIAlertController(title: "Missing", message: "Some fields are missing.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func createAppointment(){
        datePicker.isHidden = true
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true
        
        let ageF: Int = Int(ageTextFeild.text!)!
        
        let gender = genderSelect.selectedSegmentIndex
        var MorF: String = "M"
        if gender == 0
        {
            MorF = "male"
            print("male")
        }
        else if gender == 1
        {
            MorF = "female"
            print("female")

        }
        
        var apptime = ""
        apptime = "\(dateTextField.text!) \(timeTextField.text!)"
        print(apptime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.date(from: apptime)
        print(strDate as Any)
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate1 = dateFormatter1.string(from: strDate!)
        print(strDate1 as Any)
        
        codeLabel = codeButtonValue.currentTitle!
        let code1 = codeLabel.split(separator: "+", maxSplits: 2, omittingEmptySubsequences: true)
       // print("cod1:")
       // print(code1)
        let codeup = code1[0].split(separator: "▴", maxSplits: 2, omittingEmptySubsequences: true)
        //print("codup:")
        //print(codeup)
        let codedown = codeup[0].split(separator: "▾", maxSplits: 2, omittingEmptySubsequences: true)
        //print("coddown:")
        //print(codedown)
        let code2 = codedown[0]
        //print("code2")
        print(code2)
        
        
        
        let defaultValue = UserDefaults.standard
        let token = defaultValue.string(forKey: "token")
        let Auth_header    = ["Authorization" : token]
        let params: [String: Any] = ["name": nameTextField.text!, "age": ageF , "gender": String(MorF), "appointment_time": String(strDate1), "country_code": String(code2), "phone": contactTextField.text!, "description": DescriptionTV.text!]
        
        showActivityIndicator()

        request("https://app.levler.co/api/v1/customers", method: .get, parameters: params , encoding: URLEncoding(destination: .methodDependent), headers: (Auth_header as? HTTPHeaders)).validate().responseJSON { response in
            self.hideActivityIndicator()

            print("Create Appointment: \(response.result)")
            print(response)
            switch response.result {
            case .success:
                if let json = response.result.value as? NSDictionary {
                    if let msg = json["message"] as? String {
                        //  defaultValue.set(msg, forKey: "message")
                        self.nameTextField.text = ""
                        self.ageTextFeild.text = ""
                        self.dateTextField.text = ""
                        self.timeTextField.text = ""
                        self.contactTextField.text = ""
                        self.DescriptionTV.text = ""
                        
                        let alert = UIAlertController(title: "\(msg)", message: "", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                    
                else{
                    let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            case .failure:
                print("error")
                let alert = UIAlertController(title: "Error", message: "Try again..", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    
  var isDate = false
    var isTime = false
    var isOpen = false
    var isKeypadOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
       /* let swipeGesture = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipe:")))
        swipeGesture.direction = [.down, .up]
        self.view.addGestureRecognizer(swipeGesture)
    */
        self.DescriptionTV.delegate = self
       // keyboardOn()
    }
   /* func handleSwipe(swipeGesture: UISwipeGestureRecognizer) {
        print(swipeGesture.direction)
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Swiped right")
        case UISwipeGestureRecognizerDirection.down:
            print("Swiped down")
            Submit.isHidden = false
            datePicker.isHidden = true
            timePicker.isHidden = true
            countryCodePICKER.isHidden = true
            dismissKeyboard()
        case UISwipeGestureRecognizerDirection.left:
            print("Swiped left")
        case UISwipeGestureRecognizerDirection.up:
            print("Swiped up")
            Submit.isHidden = false
            datePicker.isHidden = true
            timePicker.isHidden = true
            countryCodePICKER.isHidden = true
            dismissKeyboard()
        default:
            break
        }
    }*/
    func textViewDidBeginEditing(_ textView: UITextView) {
        Submit.isHidden = false
        datePicker.isHidden = true
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true
        
        print("TextView: BEGIN EDIT")
        if isKeypadOn {
            self.view.frame.origin.y -= 100
            isKeypadOn = false
        }
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("TextView: END EDIT")
        Submit.isHidden = false
        datePicker.isHidden = true
        timePicker.isHidden = true
        countryCodePICKER.isHidden = true
        calenderShow.isHidden = true
        
        if !isKeypadOn{
            self.view.frame.origin.y += 100
            isKeypadOn = true
    
        }
        descLine.borderInactiveColor = UIColor(red: 38/255, green: 183/255, blue: 91/255, alpha: 1.0)

        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
  /*  func keyboardOn()
    {
     
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        if isKeypadOn {
        self.view.frame.origin.y -= 100
            isKeypadOn = false
        }
       

    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        if !isKeypadOn{
            self.view.frame.origin.y += 100
            isKeypadOn = true
        }

    }
 */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityIndicator() {
        
        DispatchQueue.main.async {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.theScrollview.center
            self.loadingView.backgroundColor = UIColor.lightGray
            self.loadingView.alpha = 0.9
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            self.view.alpha = 0.5
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
             self.view.alpha = 1
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
   

}
