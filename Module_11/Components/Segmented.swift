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
    private let recognizerFirst = UITapGestureRecognizer()
    private let recognizerSecond = UITapGestureRecognizer()
    
    private var delegate: SegmentedDelegate?
    
    private var segmentBackXAnchors: (first: NSLayoutConstraint, second: NSLayoutConstraint) = (NSLayoutConstraint(), NSLayoutConstraint())
    // Побывала ли подложка под обоими сегментами
    private var isFullPath = false
    
    // Параметр не отображается в Interface Builder
    @IBInspectable public var selfViewBorderColor = UIColor.red.cgColor {
        didSet { self.layer.borderColor = selfViewBorderColor }
    }
    // Параметр не отображается в Interface Builder
    @IBInspectable public var segmentOneText = "One" {
        didSet { labels.first.text = segmentOneText }
    }
    // Параметр не отображается в Interface Builder
    @IBInspectable public var segmenterTwoText = "Two" {
        didSet { labels.second.text = segmenterTwoText }
    }
    // Параметр не отображается в Interface Builder
    @IBInspectable public var segmentsBorderColor = UIColor.gray.cgColor {
        didSet {
            segments.first.layer.borderColor = segmentsBorderColor
            segments.second.layer.borderColor = segmentsBorderColor
        }
    }
    // Параметр не отображается в Interface Builder
    @IBInspectable public var segmentBackBgColor = UIColor.cyan {
        didSet { segmentBack.backgroundColor = segmentBackBgColor }
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
    
    // Подложка
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
        layer.borderColor = selfViewBorderColor
        
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
        
        // Вешаем слушатель события на 1-й сегмент
        recognizerFirst.addTarget(self, action: #selector(firstSegmentOnClick(_sender:)))
        segments.first.addGestureRecognizer(recognizerFirst)
        
        // Вешаем слушатель событий на 2-й сегмент
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
    
    // Обработчик нажатия на 1-й сегмент
    @objc private func firstSegmentOnClick(_sender: UITapGestureRecognizer) {
        delegate?.setCurrentSegment(.first)
        self.setSegmentBackCenterXAnchor(segment: .first)
    }
    
    // Обработчик нажатия на 2-й сегмент
    @objc private func secondSegmentOnClick(_sender: UITapGestureRecognizer) {
        delegate?.setCurrentSegment(.second)
        if !self.isFullPath {
            self.setSegmentBackCenterXAnchor(segment: .second, firstInteractionWithSegment: true)
            return
        }
        self.setSegmentBackCenterXAnchor(segment: .second)
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
                disappearSegmentBack()
                segmentBackXAnchors.first.isActive = false
                segmentBackXAnchors.second = segmentBack.centerXAnchor.constraint(equalTo: segments.second.centerXAnchor)
                segmentBackXAnchors.second.isActive = true
                appearSegmentBack()
                isFullPath = true
            }
            return
        }
        
        if segment == .first {
            disappearSegmentBack()
            segmentBackXAnchors.second.isActive = false
            segmentBackXAnchors.first.isActive = true
            appearSegmentBack()
            return
        }
        disappearSegmentBack()
        segmentBackXAnchors.first.isActive = false
        segmentBackXAnchors.second.isActive = true
        appearSegmentBack()
    }
    
    private func disappearSegmentBack() {
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear, animations: {
            self.segmentBack.alpha = 0
        }, completion: nil)
    }
    
    private func appearSegmentBack() {
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveLinear, animations: {
            self.segmentBack.alpha = 1
        }, completion: nil)
    }
}
