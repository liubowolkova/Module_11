//
//  ReusableClock.swift
//  Module_11
//
//  Created by Любовь Волкова on 19.08.2021.
//

import UIKit

private enum TimeStep: CGFloat {
    case hour = 12
    case minSec = 60
}

private enum WidthHeight {
    case width, height
}

@IBDesignable class ReusableClock: UIView {
    private lazy var isSetuped = false
    
    private lazy var frameWidth: CGFloat = 0
    private lazy var frameHeight: CGFloat = 0
    
    private let markers = (top: UIView(), right: UIView(), bottom: UIView(), left: UIView())
    private let markerProps: (width: CGFloat, height: CGFloat, bgColor: UIColor) = (3, 10, .green)
    
    private let arrows = (hour: UIView(), minute: UIView(), second: UIView())
    private let centerHolder = UIView()
    
    private var arrowHeight: CGFloat = 0
    private var arrowExtraHeight: CGFloat = 0
    
    @IBInspectable public var hourArrowColor: UIColor = .yellow {
        didSet { setBackgroundColor(color: hourArrowColor, views: arrows.hour) }
    }
    @IBInspectable public var minuteArrowColor: UIColor = .blue {
        didSet { setBackgroundColor(color: minuteArrowColor, views: arrows.minute) }
    }
    @IBInspectable public var secondArrowColor: UIColor = .black {
        didSet { setBackgroundColor(color: secondArrowColor, views: arrows.second) }
    }
    
    @IBInspectable public var hourArrowWidth: CGFloat = 8 {
        didSet { setHourArrowFrame() }
    }
    @IBInspectable public var hourArrowHeight: CGFloat = 40 {
        didSet { setHourArrowFrame() }
    }
    
    @IBInspectable public var minuteArrowWidth: CGFloat = 6 {
        didSet { setMinuteArrowFrame() }
    }
    @IBInspectable public var minuteArrowHeight: CGFloat = 60 {
        didSet { setMinuteArrowFrame() }
    }
    
    @IBInspectable public var secondArrowWidth: CGFloat = 2 {
        didSet { setSecondArrowFrame() }
    }
    @IBInspectable public var secondArrowHeight: CGFloat = 80 {
        didSet { setSecondArrowFrame() }
    }
    
    @IBInspectable public var timeHour: CGFloat = 0 {
        didSet {}
    }
    
    @IBInspectable public var timeMinute: CGFloat = 0 {
        didSet {}
    }
    
    @IBInspectable public var timeSecond: CGFloat = 0 {
        didSet {}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isSetuped { return }
        isSetuped = true
        
        frameWidth = frame.size.width
        frameHeight = frame.size.height
        layer.cornerRadius = frameWidth / 2
        
        arrowHeight = frameWidth / 2
        
        
        setMarkers()
        setArrows()
        addViews(superview: self, subviews: markers.top, markers.right, markers.bottom, markers.left)
        setAnchorPoints(viewNeededAnchorPoints: arrows.hour, arrows.minute, arrows.second)
        addViews(superview: self, subviews: arrows.hour, arrows.minute, arrows.second)
        //setZIndex()
        setBackgroundColor(color: hourArrowColor, views: arrows.hour)
        setBackgroundColor(color: minuteArrowColor, views: arrows.minute)
        setBackgroundColor(color: secondArrowColor, views: arrows.second)
        setCenterHolder()
        addSubview(centerHolder)
        
        setTime(time: timeHour, arrow: arrows.hour, timeStep: .hour)
        setTime(time: timeMinute, arrow: arrows.minute, timeStep: .minSec)
        setTime(time: timeSecond, arrow: arrows.second, timeStep: .minSec)
    }
    
    private func addViews(superview mainView: UIView, subviews views: UIView...) {
        for view in views {
            mainView.addSubview(view)
        }
    }
    
    private func setBackgroundColor(color: UIColor, views: UIView...) {
        for view in views {
            view.backgroundColor = color
        }
    }
    
    private func setMarkers() {
        markers.top.frame = CGRect(x: frameWidth / 2 - markerProps.width, y: 0, width: markerProps.width, height: markerProps.height)
        markers.right.frame = CGRect(x: frameWidth - markerProps.height, y: frameHeight / 2, width: markerProps.height, height: markerProps.width)
        markers.bottom.frame = CGRect(x: frameHeight / 2 - markerProps.width, y: frameHeight - markerProps.height, width: markerProps.width, height: markerProps.height)
        markers.left.frame = CGRect(x: 0, y: frameHeight / 2 - markerProps.width, width: markerProps.height, height: markerProps.width)
        
        self.setBackgroundColor(color: markerProps.bgColor, views: markers.top, markers.right, markers.bottom, markers.left)
    }
    
    private func setZIndex() {
        arrows.hour.layer.zPosition = 1
        arrows.minute.layer.zPosition = 2
        arrows.second.layer.zPosition = 3
    }
    
    private func setExtraAnchor(view: UIView, height: CGFloat) {
        
    }
    
    private func setAnchorPoints(viewNeededAnchorPoints views: UIView...) {
        for view in views {
            view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
    }
    
    private func setArrows() {
        setHourArrowFrame()
        setMinuteArrowFrame()
        setSecondArrowFrame()
    }
    
    private func setHourArrowFrame() {
        arrows.hour.frame = CGRect(x: frameWidth / 2 - hourArrowWidth, y: 0.5, width: hourArrowWidth, height: hourArrowHeight)
    }
    
    private func setMinuteArrowFrame() {
        arrows.minute.frame = CGRect(x: frameHeight / 2 - minuteArrowWidth, y: minuteArrowHeight, width: minuteArrowWidth, height: minuteArrowHeight)
    }
    
    private func setSecondArrowFrame() {
        arrows.second.frame = CGRect(x: frameWidth / 2 - secondArrowWidth, y: secondArrowHeight, width: secondArrowWidth, height: secondArrowHeight)
    }
    
    private func setCenterHolder() {
        centerHolder.backgroundColor = .darkGray
        centerHolder.frame = CGRect(x: frameWidth / 2 - 5, y: frameHeight / 2 - 5, width: 10, height: 10)
        centerHolder.layer.cornerRadius = 5
        centerHolder.layer.zPosition = 4
    }
    
    private func setTime(time: CGFloat, arrow: UIView, timeStep step: TimeStep) {
        let angle = CGFloat.pi * 2 * (time / step.rawValue)
        arrow.transform = CGAffineTransform(rotationAngle: angle)
    }
}
