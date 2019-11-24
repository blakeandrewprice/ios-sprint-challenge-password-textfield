//
//  PasswordField.swift
//  PasswordTextField
//
//  Created by Ben Gohlke on 6/26/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var passwordView = UIView()
    private var textField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        
        // Title Label
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: standardMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: standardMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin).isActive = true
        
        titleLabel.text = "ENTER PASSWORD"
        titleLabel.font = labelFont
        titleLabel.textColor = labelTextColor
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Password TextField View
        addSubview(passwordView)
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordView.layer.borderColor = textFieldBorderColor.cgColor
        passwordView.layer.borderWidth = 2
        
        passwordView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: standardMargin).isActive = true
        passwordView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        passwordView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        passwordView.heightAnchor.constraint(equalToConstant: textFieldContainerHeight).isActive = true
        
        // Password TextField
        passwordView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        
        textField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: textFieldMargin).isActive = true
        textField.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: textFieldMargin).isActive = true
        textField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -textFieldMargin * 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -textFieldMargin).isActive = true
        textField.delegate = self
        textField.isSecureTextEntry = true
        
        // Password Button
        passwordView.addSubview(showHideButton)
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: textFieldMargin),
            showHideButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: textFieldMargin),
            showHideButton.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -textFieldMargin),
            showHideButton.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -textFieldMargin)
        ])
        
        // Weak View
        addSubview(weakView)
        weakView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weakView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: standardMargin * 2),
            weakView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor),
            weakView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            weakView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        weakView.backgroundColor = weakColor
        
        // Medium View
        addSubview(mediumView)
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mediumView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: standardMargin * 2),
            mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: standardMargin / 2),
            mediumView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            mediumView.heightAnchor.constraint(equalToConstant: colorViewSize.height),
        ])
        
        mediumView.backgroundColor = unusedColor
        
        // Strong View
        addSubview(strongView)
        strongView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            strongView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: standardMargin * 2),
            strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: standardMargin / 2),
            strongView.widthAnchor.constraint(equalToConstant: colorViewSize.width),
            strongView.heightAnchor.constraint(equalToConstant: colorViewSize.height)
        ])
        
        strongView.backgroundColor = unusedColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc
    func buttonTapped(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        if !textField.isSecureTextEntry {
            let this = textField.text
            textField.text = nil
            textField.text = this
            textField.font = nil
            textField.font = UIFont.systemFont(ofSize: 14)
        }
        
        if textField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
}

extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
}
