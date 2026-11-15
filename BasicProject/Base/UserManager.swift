//
//  UserManager.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import Foundation
import Security
import SmartCodable
import RxSwift

final public class UserManager {
    public static let shared = UserManager.init()
    public let userInfoKey = "userinfokey"
    private init() {
    
    }
    /// 未读消息数
    public lazy var unreadNum = PublishSubject<Int>()
    /// 版本号
    public lazy var versionNum: Int = 0
    
    /// 网络请求登录错误
    public var loginStatusError: (() -> Void)?
    
    /// 登录成功后的回调
    public var loginSuccessCallBack: ((Any) -> Void)?
    /// 退出登录的回调
    public var logoutCallBack:(() -> Void)?
    
    ///
    public var naviServer: NavigatorServiceType?
    /// 用户信息
    public var userInfo: UserInfoModel?
    
    public var userSubject: PublishSubject<UserInfoModel?> = PublishSubject.init()
    public var loginSuccess: PublishSubject<Void> = PublishSubject.init()
    public var logoutSuccess: PublishSubject<Void> = PublishSubject.init()
    public var isLogin: Bool {
        return self.userInfo?.token?.count ?? 0 > 0
    }
    
    public var token: String {
        get {
            return self.userInfo?.token ?? ""
        }
    }
    
    public var userId: Int {
        get {
            return self.userInfo?.id ?? 0
        }
    }
    
    /// Non-sensitive profile lives in defaults; all login methods share Keychain.
    public func upLoadUserInfo(_ info: UserInfoModel? = nil) {
        if var model = info {
            if let token = model.token, !token.isEmpty {
                guard SessionKeychain.write(token) else { return }
            } else {
                model.token = SessionKeychain.read()
            }
            self.userInfo = model
            var cached = model
            cached.token = nil
            if let json = cached.toJSONString() {
                UserDefaults.standard.setValue(json, forKey: userInfoKey)
            }
            self.userSubject.onNext(model)
        } else if let json = UserDefaults.standard.string(forKey: userInfoKey),
                  var model = UserInfoModel.deserialize(from: json) {
            // Migrate older plaintext caches once, and fail closed if storage fails.
            if let old = model.token, !old.isEmpty {
                guard SessionKeychain.write(old) else {
                    UserDefaults.standard.removeObject(forKey: userInfoKey)
                    return
                }
            }
            model.token = SessionKeychain.read()
            guard model.token?.isEmpty == false else { return }
            upLoadUserInfo(model)
        }
    }

    public func clearSession() {
        SessionKeychain.clear()
        UserDefaults.standard.removeObject(forKey: userInfoKey)
        userInfo = nil
    }

    /// 必须要登陆以后才能做的事情
    public func lazyAuthToDoThings(_ block: @escaping (() -> Void)) {
        if UserManager.shared.isLogin == false {
            self.naviServer?.navigatorSubject.onNext(BaseLoginNaviItem.login)
        }
        else {
            block()
        }
    }
    
}



private enum SessionKeychain {
    static var query: [String: Any] {
        [kSecClass as String: kSecClassGenericPassword,
         kSecAttrService as String: (Bundle.main.bundleIdentifier ?? "LoveCat") + ".session",
         kSecAttrAccount as String: "system-token"]
    }
    static func read() -> String? {
        var values = query
        values[kSecReturnData as String] = true
        values[kSecMatchLimit as String] = kSecMatchLimitOne
        var result: CFTypeRef?
        guard SecItemCopyMatching(values as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }
    static func write(_ value: String) -> Bool {
        let data = Data(value.utf8)
        let status = SecItemUpdate(query as CFDictionary, [kSecValueData as String: data] as CFDictionary)
        if status == errSecSuccess { return true }
        guard status == errSecItemNotFound else { return false }
        var values = query
        values[kSecValueData as String] = data
        values[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        return SecItemAdd(values as CFDictionary, nil) == errSecSuccess
    }
    static func clear() { SecItemDelete(query as CFDictionary) }
}
