//
//  AppConfiguration.swift
//  LoveCat
//
//  Created by jingjun on 2021/4/9.
//

import Foundation

public let IMGURL      = "http://img.rxswift.cn/"
public let IMGMARK     = "?imageView2/0/q/70|watermark/2/text/QOecn-WRveWkqeWWtQ==/font/5a6L5L2T/fontsize/240/fill/IzY2NjY2Ng==/dissolve/75/gravity/SouthEast/dx/10/dy/10"
public let IMGTHUMBNAIL = "?imageView2/0/q/20"
public let IMGTHUMBFOUR = "?imageView2/0/q/40"
public let IMGTHUMBSEVEN = "?imageView2/0/q/70"
public let IMGTHUMBTHREE = "?imageView2/0/q/30"
public let RescueReleased = "RescueReleased"
public let ShowReleased   = "ShowReleased"
public let SensitiveWords = ["押金","定金","运费"]
public let CodeStr = "伍c七Alz1θVx2ψLHNpfωv九nξ捌τD六053λwGμrMνRuegsη八γ陆jOBX8ρ三E9πFS零bδοmkχ7K6PβϵϕoZ五iυU一Jq柒ydYt四QhW4玖κCIαζTaι二σ"
public let APPSTOREURL = "https://itunes.apple.com/cn/app/id1556673767"


public enum UserProtocal: String {
    case pravicy = "/api/pravicy/"
    case userAgreen = "/api/useragreen/"
    case aboutUs = "/api/aboutus/"
    case instruction = "/api/instruction/"
    case prevention = "/api/prevention/"
}

public struct APPCommonParam {
    
    public static func apiBasicParameters() -> [String:Any] {
        [
            "appType": "ios",
            "token":UserManager.shared.token,
            "appVersion": GlobalConstants.AppVersion,
            "iOSVersion": GlobalConstants.iOSVersion,
            "iOSBuildVersion": GlobalConstants.AppBuildVersion
        ]
    }
}


