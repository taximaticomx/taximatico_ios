//
//  LoginViewController.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import UIKit

enum LoginState {
    case Registration
    case Verification
}

class LoginViewController: UIViewController {
    
    lazy var phoneNumberTextField: UITextField = {
        let tf = UITextField(frame: CGRectMake(21, 343, 333, 52))
        tf.backgroundColor = UIColor.redColor()
        tf.textAlignment = .Center
        tf.delegate = self
        return tf
        }()
    
    lazy var continueButton: UIButton = {
        let b = UIButton(frame: self.phoneNumberTextField.frame)
        var newFrame = b.frame
        newFrame.origin.y += ((newFrame.size.height) + 12)
        b.frame = newFrame
        b.setTitleColor(UIColor.redColor(), forState: .Normal)
        b.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        b.addTarget(self, action: "continueButtonPressed", forControlEvents: .TouchUpInside)
        return b
        }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: "backgroundTapped")
        }()
    
    
    private(set) var currentState: LoginState?
    var state: LoginState {
        get {
            return currentState!
        }
        
        set {
            currentState = newValue
            
            switch currentState! {
            case .Registration:
                self.phoneNumberTextField.placeholder = "# DE TELEFONO"
                self.continueButton.setTitle("Continuar", forState: .Normal)
                
            case .Verification:
                self.phoneNumberTextField.placeholder = "CODIGO DE VERIFICACION"
                self.continueButton.setTitle("Verificar", forState: .Normal)
            }
        }
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.state = .Registration
        
        self.view.addSubview(self.phoneNumberTextField)
        self.view.addSubview(self.continueButton)
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer)
    }
}


// MARK: - Events
extension LoginViewController {
    func backgroundTapped() {
        self.phoneNumberTextField.resignFirstResponder()
    }
    
    func continueButtonPressed() {
        switch self.state {
        case .Registration:
            api_sendRegistrationRequest(phoneNumber: self.phoneNumberTextField.text) { success in
                if success {
                    self.state = .Verification
                }
            }
        
        case .Verification:
            api_sendVerificationCode(verificationCode: phoneNumberTextField.text) { success, token in
                if success {
                    Session(token: token!).save()
                }
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


