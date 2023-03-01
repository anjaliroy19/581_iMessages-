//
//  Main.swift
//  Sprint9
//
//  Created by Nate McMahon on 2/26/23.
//
import SwiftUI
import Foundation

      func viewDidLoad() {
      //  super.viewDidLoad()

        //Launch Keyboard on Title field
        titleTextField.becomeFirstResponder()


       let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(NewBookTableViewController.tap(_:)))
        view.addGestureRecognizer(tapGestureReconizer)
    
      
}
var keyboardHeight = CGFloat(0)   // keyboard height will be set later
    // stop keyboard controls
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        //info key
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
          keyboardHeight = keyboardSize.height
            //first key shows the keyboard size height then you can remove it as needed (hide or show)
          print(#function, keyboardHeight)
        
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            
            // default mode
            UserDefaults.standard.set(keyboardHeight, forKey: "KeyboardHeight")
            UserDefaults.standard.synchronize()
        }
    } //end of function
