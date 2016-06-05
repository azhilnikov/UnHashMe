//
//  ViewController.swift
//  UnHashMe
//
//  Created by Alexey on 4/06/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var outputHashField: UITextField!
    @IBOutlet private weak var inputHashField: UITextField!
    @IBOutlet private weak var inputStringLengthField: UITextField!
    @IBOutlet private weak var outputTextField: UITextField!
    @IBOutlet private weak var alphabetField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func restoreButtonTapped(sender: UIButton) {
        
        guard let stringHash = inputHashField.text, let hashValue = Int(stringHash) else {
            // There is no hash value or it is not Int
            inputHashField.backgroundColor = .redColor()
            return
        }
        
        inputHashField.backgroundColor = .clearColor()
        
        guard let stringLength = inputStringLengthField.text,
            let length = Int(stringLength) where length > 0 else {
            // There is no length or it is not Int or it is not greater that 0
            inputStringLengthField.backgroundColor = .redColor()
            return
        }
        
        inputStringLengthField.backgroundColor = .clearColor()
        
        let hash = Hash(alphabet: alphabetField.text!.isEmpty ? alphabetField.placeholder!
                                                              : alphabetField.text!)
        hash.restoreStringWithLength(length, from: hashValue, completion: {
            [unowned self] (text) in
            
            if nil == text {
                // Hash was not generated, display alert
                let alert = UIAlertController(title: "Can't restore text for given hash value",
                                            message: "Please check the text length or characters in alphabet",
                                     preferredStyle: .ActionSheet)
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                self.outputTextField.text = text
            }
        })
    }
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        // Hide keyboard
        view.endEditing(true)
    }
    
    // MARK: - Text field delegates
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        switch textField {
        case inputHashField, inputStringLengthField:
            textField.backgroundColor = .clearColor()
            
        case outputHashField, outputTextField:
            // Do not show keyboard for these text fields
            textField.inputView = UIView()
            
        default:
            break
        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if inputTextField == textField {
            let hash = Hash(alphabet: alphabetField.text!.isEmpty ? alphabetField.placeholder!
                                                                  : alphabetField.text!)
            hash.generateFor(inputTextField.text!, completion: {
                [unowned self] (hash) in
                
                if nil == hash {
                    // Hash was not generated, display alert
                    let alert = UIAlertController(title: "You should only use characters from alphabet",
                                                message: nil,
                                         preferredStyle: .ActionSheet)
                    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                else {
                    self.outputHashField.text = hash
                }
            })
        }
        
        // Hide keyboard
        textField.resignFirstResponder()
        return true
    }
}
