//
//  Segmented.swift
//  Module_11
//
//  Created by Любовь Волкова on 24.08.2021.
//

import UIKit

@IBDesignable
public class Segmented: UIView {
    private var isSetuped = false
    
    public var segmentOneText = "One"
    public var segmentTwoText = "Two"
    
//    @IBInspectable public var backColor: UIColor = .cyan {
//        didSet { Fast.setBackgroundColor(color: backColor, views: segmentBack) }
//    }
//    public var borderColor = UIColor.red.cgColor {
//        didSet { self.layer.borderColor = borderColor }
//    }
    
    private let labels: (first: UILabel, second: UILabel) = {
        let labels = [UILabel(), UILabel()]
        for (i, label) in labels.enumerated() {
            label.text = i == 0 ? "One" : "Two"
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        return (labels[0], labels[1])
    }()
    
    private let segments: (first: UIView, second: UIView) = {
        let segments = [UIView(), UIView()]
        for (i, segment) in segments.enumerated() {
            segment.backgroundColor = .none
            segment.layer.borderWidth = 1
            segment.layer.borderColor = UIColor.gray.cgColor
            segment.layer.zPosition = 2
            segment.translatesAutoresizingMaskIntoConstraints = false
            
            segment.widthAnchor.constraint(equalToConstant: 60).isActive = true
            segment.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        return (segments[0], segments[1])
    }()
    
    private let segmentBack: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.layer.zPosition = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.widthAnchor.constraint(equalToConstant: 66).isActive = true
        view.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        return view
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if isSetuped { return }
        isSetuped = true
        
        Fast.addViews(superview: segments.first, subviews: labels.first)
        Fast.addViews(superview: segments.second, subviews: labels.second)
        Fast.addViews(superview: self, subviews: segments.first, segments.second, segmentBack)
        
//        layer.borderWidth = 2
//        layer.borderColor = borderColor
        
        setCenterYAnchor(view1: labels.first, view2: segments.first)
        setCenterYAnchor(view1: labels.second, view2: segments.second)
        setCenterXAnchor(view1: labels.first, view2: segments.first)
        setCenterXAnchor(view1: labels.second, view2: segments.second)
        
        setCenterYAnchor(view1: segments.first, view2: segments.second)
        setCenterYAnchor(view1: segments.first, view2: self)
        
        setCenterXAnchor(view1: segmentBack, view2: segments.first)
        setCenterYAnchor(view1: segmentBack, view2: self)
        
        segments.first.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        segments.second.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    
    private func setCenterYAnchor(view1: UIView, view2: UIView) {
        view1.centerYAnchor.constraint(equalTo: view2.centerYAnchor).isActive = true
    }
    
    private func setCenterXAnchor(view1: UIView, view2: UIView) {
        view1.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
    }
}
