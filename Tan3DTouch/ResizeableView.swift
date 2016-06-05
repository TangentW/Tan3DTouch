//
//  ResizeableView.swift
//  Tan3DTouch
//
//  Created by Tan on 16/6/4.
//  Copyright © 2016年 Tangent. All rights reserved.
//

import UIKit

class ResizeableView: UIView {
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var multiple: CGFloat = 0.0
        if let force = touches.first?.force, let maximumPossibleForce = touches.first?.maximumPossibleForce {
            multiple = force / maximumPossibleForce
        }
        self.transform = CGAffineTransformMakeScale(1 + multiple, 1 + multiple)
    }
}
