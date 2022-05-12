//
//  LoginModel.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import Foundation
import HandyJSON

public struct UserInfoModel: HandyJSON {
    public init(){}
    public var username: String?
    public var avator: String?
    public var token: String?
    public var phone_number: String?
    public var email: String?
    public var create_time: String?
    public var id: Int?
    public var wx_id: String?
}
