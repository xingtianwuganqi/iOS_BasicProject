//
//  LoginModel.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import Foundation
import SmartCodable

public struct UserInfoModel: SmartCodableX {
    public init(){}
    public var username: String?
    public var avator: String?
    public var token: String?
    public var phone_number: String?
    public var email: String?
    public var create_time: String?
    public var id: Int?
    public var auth_method: String?
    public var identity: UserIdentityModel?
    public var capabilities: UserCapabilitiesModel?
    public var wx_id: String?
}

public struct UserIdentityModel: SmartCodableX {
    public init() {}
    public var apple_linked: Bool?
    public var verified_by: String?
    public var phone_verified: Bool?
    public var email_verified: Bool?
}
public struct UserCapabilitiesModel: SmartCodableX {
    public init() {}
    public var identity_verified: Bool?
    public var requires_phone_binding: Bool?
}
