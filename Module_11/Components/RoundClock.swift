//
//  RoundClock.swift
//  Module_11
//
//  Created by Любовь Волкова on 23.08.2021.
//

import UIKit

private enum TimeStep: CGFloat {
    case hour = 12
    case minSec = 60
}

@IBDesignable
public class RoundClock: RoundBase {
    private let hour = Arrow()
    @IBInspectable public var hourWidth: CGFloat = 10 {
        didSet {
            hour.width = hourWidth
            setArrow(arrow: hour, width: hourWidth, height: hourHeight)
        }
    }
    @IBInspectable public var hourHeight: CGFloat = 60 {
        didSet {
            hour.height = hourHeight
            setArrow(arrow: hour, width: hourWidth, height: hourHeight)
        }
    }
    @IBInspectable public var hourTime: CGFloat = 0 {
        didSet { layoutIfNeeded() }
    }
    @IBInspectable public var hourColor: UIColor = .green {
        didSet { hour.color = hourColor }
    }
    
    // Убрать комменты при необходимости 3-х стрелок
    
//    private let minute = Arrow()
//    @IBInspectable public var minuteWidth: CGFloat = 10 {
//        didSet {
//            minute.width = minuteWidth
//            setArrow(arrow: minute, width: minuteWidth, height: minuteHeight)
//        }
//    }
//    @IBInspectable public var minuteHeight: CGFloat = 60 {
//        didSet {
//            minute.height = minuteHeight
//            setArrow(arrow: minute, width: minuteWidth, height: minuteHeight)
//        }
//    }
//    @IBInspectable public var minuteTime: CGFloat = 0 {
//        didSet { layoutIfNeeded() }
//    }
//    @IBInspectable public var minuteColor: UIColor = .green {
//        didSet { minute.color = minuteColor }
//    }
    
    
//    private let second = Arrow()
//    @IBInspectable public var secondWidth: CGFloat = 10 {
//        didSet {
//            second.width = secondWidth
//            setArrow(arrow: second, width: secondWidth, height: secondHeight)
//        }
//    }
//    @IBInspectable public var secondHeight: CGFloat = 60 {
//        didSet {
//            second.height = secondHeight
//            setArrow(arrow: second, width: secondWidth, height: secondHeight)
//        }
//    }
//    @IBInspectable public var secondTime: CGFloat = 0 {
//        didSet { layoutIfNeeded() }
//    }
//    @IBInspectable public var secondColor: UIColor = .green {
//        didSet { second.color = secondColor }
//    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        setArrow(arrow: hour, width: hourWidth, height: hourHeight)
        //setArrow(arrow: minute, width: minuteWidth, height: minuteHeight)
        //setArrow(arrow: second, width: secondWidth, height: secondHeight)
        Fast.addViews(superview: self, subviews: hour /*, minute, second*/)
        setAnchorPoints(viewNeededAnchorPoints: hour /*, minute, second*/)
        
        setTime(time: hourTime, arrow: hour, timeStep: .hour)
        //setTime(time: minuteTime, arrow: minute, timeStep: .minSec)
        //setTime(time: secondTime, arrow: second, timeStep: .minSec)
    }
    
    private func setArrow(arrow: Arrow, width: CGFloat, height: CGFloat) {
        arrow.frame = CGRect(x: frameWidth / 2 - width / 2, y: frameHeight / 2 - height / 2, width: width, height: height)
    }
    
    private func setTime(time: CGFloat, arrow: UIView, timeStep step: TimeStep) {
        let angle = CGFloat.pi * 2 * (time / step.rawValue)
        arrow.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    private func setAnchorPoints(viewNeededAnchorPoints views: UIView...) {
        for view in views {
            view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        }
    }
}
