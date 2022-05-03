//
//  Common.swift
//  LoveCat
//
//  Created by jingjun on 2020/10/19.
//

import Foundation
import UIKit
public let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public let SCREEN_WIDTH  = UIScreen.main.bounds.size.width

public func isIphoneXSeries() -> Bool {
    guard let window = UIApplication.shared.keyWindow else {
        return false
    }
    if #available(iOS 11.0, *) {
        return window.safeAreaInsets.bottom > 0
    } else {
        return false
    }
}

// 相对iPhoneXS max的宽度适配
public func scaleSize(_ size: CGFloat) -> CGFloat { size * min((SCREEN_WIDTH / 414), 1.5) }
// 相对iPhoneX 的宽度适配
public func scaleXSize(_ size: CGFloat) -> CGFloat { size * min((SCREEN_WIDTH / 375), 1.5) }

/// 状态栏高度
public let SystemStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
/// 导航栏高度
public let SystemNavigationBarContentHeight: CGFloat = 44.0
/// 状态栏 + 导航栏
public let SystemNavigationBarHeight: CGFloat = SystemNavigationBarContentHeight + SystemStatusBarHeight
/// tabbar内容高度
public let SystemTabBarContentHeight: CGFloat = 49.0
/// tabbar总高度
public let SystemTabBarHeight: CGFloat = isIphoneXSeries() ? SystemTabBarContentHeight + 34.0 : SystemTabBarContentHeight
public let isIOS10Later = (NSFoundationVersionNumber >= NSFoundationVersionNumber10_0)
/// 安全底高度
public let SystemSafeBottomHeight: CGFloat = isIphoneXSeries() ? 34.0 : 0

public func printLog<N>(_ message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
    print("message:\(message)\nway:\(fileName as NSString) methods:\(methodName) line:\(lineNumber)")
    #endif
}

public enum GlobalConstants {
    
    #if DEBUG
    public static let isEnabledDebugShowTimeTouch = true
    #else
    public static let isEnabledDebugShowTimeTouch = false
    #endif
    
    // 2.3.5
    public static let AppVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    public static let AppBundleIdentifier = (Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String) ?? ""
    // 235
    public static let AppIntegerVersion = AppVersion.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
    public static let iOSVersion = UIDevice.current.systemVersion
    public static let AppDisplayName = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
    public static let AppLookLink = (Bundle.main.infoDictionary?["RTAppLookLink"] as? String) ?? ""
    public static let AppDownloadLink = (Bundle.main.infoDictionary?["RTNewAppDownLoadLink"] as? String) ?? ""
    public static let AppStoreDownloadLink = (Bundle.main.infoDictionary?["RTAppDownloadLink"] as? String) ?? ""
    public static let AppBuildVersion = (Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "1000"
}
