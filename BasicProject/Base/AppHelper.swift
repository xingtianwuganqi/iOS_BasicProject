//
//  AppHelper.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import Foundation
import RxSwift
public final class AppHelper {
    public static let shared = AppHelper.init()
    private init() {
        
    }
    
    public var url_config: [String: String] = [:]
    
    public static func currentTabBarController() -> UITabBarController? {
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            return rootViewController
        }
        return nil
    }
    
    public static func topNavigationController() -> UINavigationController? {
        var nac = UIViewController.topViewController()?.navigationController
        if nac == nil || nac?.isKind(of: UIImagePickerController.self) == true {
            // 需要排除掉UIImagePickerController
            nac = AppHelper.currentTabBarController()?.selectedViewController as? UINavigationController
        }
        
        return nac
    }
    
    public static func topWindow() -> UIWindow? {
        let windows = UIApplication.shared.windows
        let UIRemoteKeyboardWindow: AnyClass? = NSClassFromString("UIRemoteKeyboardWindow")
        let topWindow = windows.last {
            if $0.bounds.equalTo(UIScreen.main.bounds) == true {
                if let UIRemoteKeyboardWindow = UIRemoteKeyboardWindow, $0.isKind(of: UIRemoteKeyboardWindow) {
                    return false
                }
                return true
            }
            return false
        }
        if let window = topWindow {
            return window
        }
        return UIApplication.shared.keyWindow
    }
    
    
    
}

