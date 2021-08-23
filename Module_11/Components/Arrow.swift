//
//  Arrow.swift
//  Module_11
//
//  Created by Любовь Волкова on 23.08.2021.
//

import UIKit

public class Arrow: UIView {
    public var width: CGFloat = 10 {
        didSet { updateArrow() }
    }
    public var height: CGFloat = 60 {
        didSet { updateArrow() }
    }
    public var color: UIColor = .green {
        didSet { updateColor() }
    }
    
    private var shape = CAShapeLayer()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        shape = drawArrow()
        self.layer.addSublayer(shape)
    }
    
    private func drawArrow() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: width / 2))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: width, y: width / 2))
        path.addLine(to: CGPoint(x: width - 4, y: height))
        path.addLine(to: CGPoint(x: 4, y: height))
        path.addLine(to: CGPoint(x: 0, y: width / 2))
        
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color.cgColor
        
        return shapeLayer
    }
    
    private func updateArrow() {
        shape.removeFromSuperlayer()
        shape = drawArrow()
        self.layer.addSublayer(shape)
    }
    
    private func updateColor() {
        shape.fillColor = color.cgColor
    }
}
