//
//  File.swift
//  Module_11
//
//  Created by Любовь Волкова on 23.08.2021.
//

import UIKit

public class Fast {
    static func setBackgroundColor(color: UIColor, views: UIView...) {
        for view in views {
            view.backgroundColor = color
        }
    }
    
    static func addViews(superview mainView: UIView, subviews views: UIView...) {
        for view in views {
            mainView.addSubview(view)
        }
    }
}
