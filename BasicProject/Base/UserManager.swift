//
//  UserManager.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import Foundation
import HandyJSON
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
    
    public func upLoadUserInfo(_ info: UserInfoModel? = nil) {
        if let userInfo = info {
            self.userInfo = userInfo
            if let json = self.userInfo?.toJSONString() {
                UserDefaults.standard.setValue(json, forKey: userInfoKey)
            }
            self.userSubject.onNext(userInfo)
        }else{
            guard let infoStr = UserDefaults.standard.value(forKey: userInfoKey) as? String,infoStr.count > 0 else{
                return
            }
            let model = JSONDeserializer<UserInfoModel>.deserializeFrom(json: infoStr)
            self.userInfo = model
            if let info = model {
                self.userSubject.onNext(info)
            }
        }
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


