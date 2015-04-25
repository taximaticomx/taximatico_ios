//
//  LoginViewController.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var phoneNumberTextField: UITextField = {
        let tf = UITextField(frame: CGRectMake(21, 343, 333, 52))
        tf.backgroundColor = UIColor.redColor()
        tf.placeholder = "# DE TELEFONO"
        tf.textAlignment = .Center
        tf.delegate = self
        return tf
        }()
    
    lazy var continueButton: UIButton = {
        let b = UIButton(frame: self.phoneNumberTextField.frame)
        var newFrame = b.frame
        newFrame.origin.y += ((newFrame.size.height) + 12)
        b.frame = newFrame
        b.setTitle("Continuar", forState: .Normal)
        b.setTitleColor(UIColor.redColor(), forState: .Normal)
        b.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        return b
        }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: "backgroundTapped")
        }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.phoneNumberTextField)
        self.view.addSubview(self.continueButton)
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer)
    }
    
    func backgroundTapped() {
        self.phoneNumberTextField.resignFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


