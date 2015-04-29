//
//  LoginViewController.swift
//  taximatico_ios
//
//  Created by Oscar Swanros on 4/25/15.
//  Copyright (c) 2015 Taximatico. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var logoImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "LogoImage"))
        i.setTranslatesAutoresizingMaskIntoConstraints(false)
        i.contentMode = .ScaleAspectFit
        return i
        }()
    
    lazy var messageLabel: UILabel = {
        let l = UILabel()
        l.setTranslatesAutoresizingMaskIntoConstraints(false)
        l.text = "Pedir un taxi nunca había\nsido tan fácil."
        l.numberOfLines = 0
        l.lineBreakMode = .ByWordWrapping
        l.textAlignment = .Center
        l.font = UIFont.systemFontOfSize(25)
        return l
        }()
    
    lazy var textField: UITextField = {
        let tf = UITextField(frame: CGRectMake(21, 343, 333, 52))
        tf.textAlignment = .Center
        tf.delegate = self
        tf.placeholder = "# DE TELEFONO"
        tf.backgroundColor = UIColor.tx_lightGreyColor()
        return tf
        }()
    
    lazy var continueButton: UIButton = {
        let b = UIButton(frame: self.textField.frame)
        var newFrame = b.frame
        newFrame.origin.y += ((newFrame.size.height) + 12)
        b.frame = newFrame
        b.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        b.setTitleColor(UIColor.blackColor(), forState: .Highlighted)
        b.backgroundColor = UIColor.tx_disabledColor()
        b.addTarget(self, action: "continueButtonPressed", forControlEvents: .TouchUpInside)
        b.setTitle("Continuar", forState: .Normal)
        return b
        }()
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: "backgroundTapped")
        }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.logoImageView)
        self.view.addConstraints(self.constraintsForLogoImageView())
        
        self.view.addSubview(self.messageLabel)
        self.view.addConstraints(self.constraintsForMessageLabel())
        
        self.view.addSubview(self.textField)
        self.view.addSubview(self.continueButton)
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer)
    }
}


// MARK: - Events
extension LoginViewController {
    func backgroundTapped() {
        self.textField.resignFirstResponder()
    }
    
    func continueButtonPressed() {
            api_sendRegistrationRequest(phoneNumber: self.textField.text) { success in
                if success {
                }
            }
    }
}


// MARK: - Text field Delegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: - Constraints

extension LoginViewController {
    func constraintsForLogoImageView() -> [AnyObject] {
        var constraints = [AnyObject]()
        
        constraints.append(NSLayoutConstraint(item: self.logoImageView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 43))
        constraints.append(NSLayoutConstraint(item: self.logoImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100))
        constraints += NSLayoutConstraint.constraintsWithVisualFormat("|-17-[logoImageView]-17-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["logoImageView": self.logoImageView])
        
        return constraints
    }
    
    //    func constraintsForTextField() -> [AnyObject] {
    //        var constraints = [AnyObject]()
    //
    //        constraints.append(NSLayoutConstraint(item: self.textField, attribute: .Top, relatedBy: .Equal, toItem: self.logoImageView, attribute: .Bottom, multiplier: 1, constant: <#CGFloat#>))
    //
    //        return constraints
    //    }
    
    func constraintsForMessageLabel() -> [AnyObject] {
        var constraints = [AnyObject]()
        
        constraints.append(NSLayoutConstraint(item: self.messageLabel, attribute: .Top, relatedBy: .Equal, toItem: self.logoImageView, attribute: .Bottom, multiplier: 1, constant: 14))
        constraints.append(NSLayoutConstraint(item: self.messageLabel, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 60))
        constraints.append(NSLayoutConstraint(item: self.messageLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: CGRectGetWidth(self.view.frame) * 0.74))
        constraints.append(NSLayoutConstraint(item: self.messageLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        
        return constraints
    }
}