//
//  Button.swift
//  Module_11
//
//  Created by Любовь Волкова on 15.08.2021.
//

import UIKit

@IBDesignable class Button: UIButton {
    private lazy var isSetuped = false
    
    @IBInspectable public var borderWidth: CGFloat = 3 {
        didSet { self.setBorderWidth() }
    }
    
    @IBInspectable public var borderColor: UIColor = .green {
        didSet { self.setBorderColor() }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 10 {
        didSet { self.setCornerRadius() }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isSetuped { return }
        isSetuped = true
        
        self.setTitle("CustomButton", for: .normal)
        self.backgroundColor = .yellow
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
    
    private func setBorderWidth() {
        self.layer.borderWidth = borderWidth
    }
    
    private func setBorderColor() {
        self.layer.borderColor = borderColor.cgColor
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = cornerRadius
    }
}
