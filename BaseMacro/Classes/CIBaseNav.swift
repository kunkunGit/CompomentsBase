//
//  CIBaseNav.swift
//  CIProject
//
//  Created by kunkun on 2019/8/19.
//  Copyright © 2019年 CJ Co,Ltd. All rights reserved.
//

import Foundation

//extension UINavigationController: UIGestureRecognizerDelegate
//{
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//        self.interactivePopGestureRecognizer?.delegate = self
//    }
//    
//    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return self.childViewControllers.count > 1
//    }
//    
//    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if self.viewControllers.count > 0 {
//            self.hidesBottomBarWhenPushed = true
//        }
//    }
//    
//}

class CiBaseNav: UINavigationController, UIGestureRecognizerDelegate {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.interactivePopGestureRecognizer?.delegate = self
//
//    }
//
//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return self.childViewControllers.count > 1
//    }
//
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if self.viewControllers.count > 0 {
//            self.hidesBottomBarWhenPushed = true
//        }
//    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    
}
