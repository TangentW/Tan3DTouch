//
//  DetailViewController.swift
//  Tan3DTouch
//
//  Created by Tan on 16/6/4.
//  Copyright © 2016年 Tangent. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private static let mainTitleLabelHeight: CGFloat = 50.0
    
    var mainTitle: String? {
        didSet {
            self.mainTitleLabel.text = mainTitle
        }
    }
    
    private lazy var previewActions: [UIPreviewActionItem] = {
        let action1 = UIPreviewAction(title: "分享", style: .Default, handler: { action, viewController in
            print("Peek quick actions- 分享")
        })
        let action2 = UIPreviewAction(title: "搜索", style: .Default, handler: { action, viewController in
            print("Peek quick actions- 搜索")
        })
        let action3 = UIPreviewActionGroup(title: "更多", style: .Default, actions: [action1, action2])
        return [action1, action2, action3]
    }()
    
    private lazy var mainTitleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(17)
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.mainTitleLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let viewControllersViewHeight = self.view.bounds.size.height
        let viewControllersViewWidth = self.view.bounds.size.width
        self.mainTitleLabel.frame = CGRectMake(0, 0.5 * (viewControllersViewHeight - DetailViewController.mainTitleLabelHeight), viewControllersViewWidth, DetailViewController.mainTitleLabelHeight)
    }
    
    //  MARK: - Setup PreviewActionItems
    override func previewActionItems() -> [UIPreviewActionItem] {
        return self.previewActions
    }

}
