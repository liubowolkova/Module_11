//
//  RoundBase.swift
//  Module_11
//
//  Created by Любовь Волкова on 23.08.2021.
//

import UIKit

@IBDesignable
public class RoundBase: UIView {
    private lazy var isSetuped = false
    
    public lazy var frameWidth: CGFloat = 0
    public lazy var frameHeight: CGFloat = 0
    
    private let markers = (top: UIView(), right: UIView(), bottom: UIView(), left: UIView())
    @IBInspectable public var markerColor: UIColor = .red {
        didSet { Fast.setBackgroundColor(color: markerColor, views: markers.top, markers.right, markers.bottom, markers.left) }
    }
    @IBInspectable public var markerWidth: CGFloat = 4 {
        didSet { setMarkers() }
    }
    @IBInspectable public var markerHeight: CGFloat = 10 {
        didSet { setMarkers() }
    }
    
    private let centerHolder = UIView()
    @IBInspectable public var centerColor: UIColor = .orange {
        didSet { Fast.setBackgroundColor(color: centerColor, views: centerHolder) }
    }
    @IBInspectable public var centerSize: CGFloat = 10 {
        didSet { setCenterHolder() }
    }
    @IBInspectable public var centerZIndex: CGFloat = 1 {
        didSet { centerHolder.layer.zPosition = centerZIndex }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if isSetuped { return }
        isSetuped = true
        
        frameWidth = frame.size.width
        frameHeight = frame.size.height
        layer.cornerRadius = frameWidth / 2
        
        setMarkers()
        Fast.setBackgroundColor(color: markerColor, views: markers.top, markers.right, markers.bottom, markers.left)
        
        setCenterHolder()
        Fast.setBackgroundColor(color: centerColor, views: centerHolder)
        centerHolder.layer.zPosition = 1
        
        Fast.addViews(superview: self, subviews: markers.top, markers.right, markers.bottom, markers.left, centerHolder)
    }
    
    private func setMarkers() {
        markers.top.frame = CGRect(x: frameWidth / 2 - markerWidth / 2, y: 0, width: markerWidth, height: markerHeight)
        markers.right.frame = CGRect(x: frameWidth - markerHeight, y: frameHeight / 2 - markerWidth / 2, width: markerHeight, height: markerWidth)
        markers.bottom.frame = CGRect(x: frameHeight / 2 - markerWidth / 2, y: frameHeight - markerHeight, width: markerWidth, height: markerHeight)
        markers.left.frame = CGRect(x: 0, y: frameHeight / 2 - markerWidth / 2, width: markerHeight, height: markerWidth)
    }
    
    private func setCenterHolder() {
        centerHolder.frame = CGRect(x: frameWidth / 2 - centerSize / 2, y: frameHeight / 2 - centerSize / 2, width: centerSize, height: centerSize)
        centerHolder.layer.cornerRadius = centerSize / 2
    }
}
