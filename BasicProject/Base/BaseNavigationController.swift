//
//  BaseNavigationController.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/11.
//

import UIKit

public class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        configureNavigationBarAppearance()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureNavigationBarAppearance()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        interactivePopGestureRecognizer?.delegate = self
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
    }
    
    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = UIColor.color(.defIcon)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
        navigationBar.tintColor = .black
    }
}
extension BaseNavigationController {
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 这个方法是在当前控制器执行push的时候，禁止手势右划返回，避免出现crash的现象
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) == true {
            interactivePopGestureRecognizer?.isEnabled = false
        }

        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            if viewController.navigationItem.leftBarButtonItem == nil {
                let backNavBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40.0))
                backNavBtn.contentHorizontalAlignment = .left
                backNavBtn.setImage(UIImage(named: "icon_a_back"), for: .normal)
                backNavBtn.setImage(UIImage(named: "icon_a_back"), for: .highlighted)
                backNavBtn.addTarget(viewController, action: #selector(gobackByPopViewController), for: .touchUpInside)
                let backItem = UIBarButtonItem(customView: backNavBtn)
                viewController.navigationItem.leftBarButtonItem = backItem
            }
        }
        super.pushViewController(viewController, animated: animated)
        //处理了push后隐藏底部UITabBar的情况，并解决了iPhonX上push时UITabBar上移的问题。
        if var rect = tabBarController?.tabBar.frame {
            rect.origin.y = UIScreen.main.bounds.size.height - rect.size.height
            tabBarController?.tabBar.frame = rect
        }
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        super.popViewController(animated: animated)
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        super.popToViewController(viewController, animated: animated)
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        super.popToRootViewController(animated: animated)
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // 这个方法是在当前控制器执行push的时候，禁止手势右划返回，避免出现crash的现象
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) == true {
            interactivePopGestureRecognizer?.isEnabled = viewControllers.count > 1
        }
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension UIViewController {
    @objc func gobackByPopViewController() {
        navigationController?.popViewController(animated: true)
    }
}
