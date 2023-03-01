//
//  mainTest.swift
//  Sprint9
//
//  Created by Nate McMahon on 3/1/23.
//

import Foundation
// keyboard controls for text
    // as the enter key is pressed the keyboard will be dismissed
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder() // get rid of keyboard when you hit return
             return false
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        self.view.endEditing(true)
    }
    

    // moving keyboard up and down
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.orange.cgColor
        

        //move up
        var moveValueUp:CGFloat = 0.0
        
        if textField == locationTextField {
            moveValueUp = CGFloat(keyboardHeight)
        }
        if textField == urlTextField {
                    moveValueUp = CGFloat(keyboardHeight)
                }
         
                if textField == user3TextField {
                    moveValueUp = CGFloat(keyboardHeight)
                }
                
                if moveValueUp > 0 {
                    animateViewMoving(true, moveValue: moveValueUp)
                }
                
            }
            
            func textFieldDidEndEditing(_ textField: UITextField) {
                
                textField.layer.borderWidth = 0
                textField.layer.borderColor = UIColor.clear.cgColor
                //move down
                var moveValueDown: CGFloat = 0.0
                
                if textField == locationTextField {
                    moveValueDown = CGFloat(keyboardHeight)
                }
                if textField == urlTextField {
                    moveValueDown = CGFloat(keyboardHeight)
                }
                if textField == user3TextField {
                            moveValueDown = CGFloat(keyboardHeight)
                        }
                        if moveValueDown > 0 {
                            animateViewMoving(false, moveValue: moveValueDown)
                        }
                        
                    }
