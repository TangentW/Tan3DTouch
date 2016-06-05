//
//  TouchViewController.swift
//  Tan3DTouch
//
//  Created by Tan on 16/6/4.
//  Copyright © 2016年 Tangent. All rights reserved.
//

import UIKit

class TouchViewController: UIViewController {
    
    private let mViewSizeValue: CGFloat = 70.0
    
    private lazy var mView: ResizeableView = {
        let view = ResizeableView()
        view.backgroundColor = UIColor.redColor()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.mView)
        self.mView.frame = CGRectMake(100, 200, mViewSizeValue, mViewSizeValue)
    }

}
