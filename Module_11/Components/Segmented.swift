//
//  Segmented.swift
//  Module_11
//
//  Created by Любовь Волкова on 24.08.2021.
//

import UIKit

public enum CurrentSegment: String {
    case first = "First Segment"
    case second = "Second Segment"
}

protocol SegmentedDelegate {
    func setCurrentSegment(_ segment: CurrentSegment)
}

@IBDesignable
public class Segmented: UIView {
    public var segmentOneText = "One"
    public var segmentTwoText = "Two"
    
    private let recognizerFirst = UITapGestureRecognizer()
    private let recognizerSecond = UITapGestureRecognizer()
    
    private var delegate: SegmentedDelegate?
    
    private var segmentBackXAnchors: (first: NSLayoutConstraint, second: NSLayoutConstraint) = (NSLayoutConstraint(), NSLayoutConstraint())
    // Побывала ли подложка под обоими сегментами
    private var isFullPath = false
    
    @IBInspectable public var borderColor = UIColor.red.cgColor {
        didSet { self.layer.borderColor = borderColor }
    }
    
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
    
    public func makeSets() {
        // Добавляем лейблы на сегменты
        Fast.addViews(superview: segments.first, subviews: labels.first)
        Fast.addViews(superview: segments.second, subviews: labels.second)
        // Добавляем сегменты и подложку на view
        Fast.addViews(superview: self, subviews: segments.first, segments.second, segmentBack)
        
        layer.borderWidth = 2
        layer.borderColor = borderColor
        
        // Центрируем лейблы внутри сегментов
        setCenterYAnchor(view1: labels.first, view2: segments.first)
        setCenterYAnchor(view1: labels.second, view2: segments.second)
        setCenterXAnchor(view1: labels.first, view2: segments.first)
        setCenterXAnchor(view1: labels.second, view2: segments.second)
        
        // Центрируем оба сегмента по оси Y
        setCenterYAnchor(view1: segments.first, view2: segments.second)
        setCenterYAnchor(view1: segments.first, view2: self)
        
        // Центрируем подложку относительно 1-го сегмента
        setSegmentBackCenterXAnchor(segment: .first, firstInteractionWithSegment: true)
        //setFirstX(view1: segmentBack, view2: segments.first)
        setCenterYAnchor(view1: segmentBack, view2: self)
        
        // Привязываем сегменты к левому и правому краям соответственно
        segments.first.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        segments.second.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        

        recognizerFirst.addTarget(self, action: #selector(firstSegmentOnClick(_sender:)))
        segments.first.addGestureRecognizer(recognizerFirst)
        
        recognizerSecond.addTarget(self, action: #selector(secondSegmentOnClick(_sender:)))
        segments.second.addGestureRecognizer(recognizerSecond)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        makeSets()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        makeSets()
    }
    
    @objc private func firstSegmentOnClick(_sender: UITapGestureRecognizer) {
        print("first segment clicked")
        setSegmentBackCenterXAnchor(segment: .first)
    }
    
    @objc private func secondSegmentOnClick(_sender: UITapGestureRecognizer) {
        print("second segment clicked")
        
        if !isFullPath {
            setSegmentBackCenterXAnchor(segment: .second, firstInteractionWithSegment: true)
            return
        }
        setSegmentBackCenterXAnchor(segment: .second)
    }
    
    private func setCenterYAnchor(view1: UIView, view2: UIView) {
        view1.centerYAnchor.constraint(equalTo: view2.centerYAnchor).isActive = true
    }
    
    private func setCenterXAnchor(view1: UIView, view2: UIView) {
        view1.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
    }
    
    private func setSegmentBackCenterXAnchor(segment: CurrentSegment, firstInteractionWithSegment: Bool = false) {
        if firstInteractionWithSegment {
            switch segment {
            case .first:
                segmentBackXAnchors.first = segmentBack.centerXAnchor.constraint(equalTo: segments.first.centerXAnchor)
                segmentBackXAnchors.first.isActive = true
            case .second:
                segmentBackXAnchors.first.isActive = false
                segmentBackXAnchors.second = segmentBack.centerXAnchor.constraint(equalTo: segments.second.centerXAnchor)
                segmentBackXAnchors.second.isActive = true
                isFullPath = true
            }
            return
        }
        
        if segment == .first {
            segmentBackXAnchors.second.isActive = false
            segmentBackXAnchors.first.isActive = true
            return
        }
        segmentBackXAnchors.first.isActive = false
        segmentBackXAnchors.second.isActive = true
    }
}
