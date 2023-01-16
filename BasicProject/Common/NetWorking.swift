//
//  NetWorking.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/15.
//

import Foundation
import Moya
import RxSwift
import HandyJSON
import Alamofire
import MBProgressHUD

public var baseUrlConfig: String = ""

public struct EmptyModel: HandyJSON {
    public init() {}
}

public struct BaseModel<T: HandyJSON>: HandyJSON {
    
    public typealias ModelType = T
    
    public var code: Int?
    public var message: String?
    public var data: ModelType?
    public var dataArr: [ModelType]?
    public var isSuccess: Bool = false
    
    public init() {}
    
    mutating public func mapping(mapper: HelpingMapper) {
        mapper <<< self.dataArr <-- "data"
        mapper <<< self.data <-- "data"
    }
    
    mutating public func didFinishMapping() {
        if code == 200 {
            isSuccess = true
        }
    }
}


public protocol BaseTargetType: TargetType {
    var parameters: [String: Any] { get }
}

extension BaseTargetType {
    public var task: Task {
        let encoding: ParameterEncoding
            encoding = URLEncoding.default
        return .requestParameters(parameters: parameters, encoding: encoding)
        /*
         return Task.requestParameters(parameters: self.parameters?.values ?? [:], encoding: URLEncoding.default)
         */
    }
   
    
    public var method: Moya.Method {
        return .post
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var stubBehavior: StubBehavior {
        return .never
    }
    
    public var sampleData: Data {
        return Data()
    }

    public var headers: [String : String]? {
        return [:]
    }
    
    public var baseURL: URL {
        return URL(string: baseUrlConfig)!
    }
}

public final class NetWorking<T: BaseTargetType> : MoyaProvider<T>{
//    init() {
//
////        let token = "d3d833b59e00683a1cba7323:65cfc43e022d003f39c102f9"
////        let baseStr = token.data(using: .utf8)?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
//////        return ["Authorization": "Basic \(baseStr ?? "")"]
////        let dic = ["Authorization": "Basic \(baseStr ?? "")"]
//
//        let configuration = URLSessionConfiguration.af.default
//        configuration.timeoutIntervalForRequest = 20
//        configuration.timeoutIntervalForResource = 20
//        configuration.requestCachePolicy = .useProtocolCachePolicy
//
//        let pathStr = baseUrlConfig == .test ? "test" : "rescue"
//        let domain = baseUrlConfig == .test ? "test.rxswift.cn" : "rescue.rxswift.cn"
//        let path: String = Bundle.main.path(forResource: pathStr, ofType: "cer") ?? ""
//        let certificationData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData
//
//        let certificate = SecCertificateCreateWithData(nil, certificationData!)
//        let certificates: [SecCertificate] = [certificate!]
//
//        let trusPolicy = PinnedCertificatesTrustEvaluator(certificates: certificates, acceptSelfSignedCertificates: false, performDefaultValidation: true, validateHost: true)
//        let trustManager = ServerTrustManager(evaluators: [domain : trusPolicy])
//
//        let session = Alamofire.Session.init(configuration: configuration, delegate: SessionDelegate.init(), rootQueue: DispatchQueue.main,serverTrustManager: trustManager)
//
//        super.init(callbackQueue: DispatchQueue.main, session: session, plugins: [])
//    }

    public func request(
        _ target: T,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
        ) -> Single<Response> {
        printLog("😀😀😀 beginRequest: \(target.baseURL)\(target.path) ---- \(target.method) --- \(target.parameters)")
        return self.rx.request(target)
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { (response) in
                printLog("🥳🥳🥳 Success: \(response.statusCode)")
//                printLog(try response.mapJSON())
        }, onError: { (error) in
            let err = error as! MoyaError
            if let baseModel = err.response?.mapModel(EmptyModel.self),baseModel.code == 401 {
                DispatchQueue.main.async {
                    MBProgressHUD.xy_show("认证有误,请重新登录")
                    UserManager.shared.loginStatusError?()
                }
            }
            printLog("☹️☹️☹️ Error: \(target.baseURL)\(target.path) ---- \(err.response?.statusCode ?? 0)")
        })
    }
}


extension ObservableType where Element == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<BaseModel<T>?> {
        return flatMap { response -> Observable<BaseModel<T>?> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

extension Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> BaseModel<T>? {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<BaseModel<T>>.deserializeFrom(json: jsonString)
    }
}

extension Single where Element == Any {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Single<BaseModel<T>?> {
        let obj = self.asObservable().flatMap { (data) -> Observable<BaseModel<T>?> in
            let json = data as! [String: Any]
            let resp = JSONDeserializer<BaseModel<T>>.deserializeFrom(dict: json)
            return Observable.just(resp)
          }
        return obj.asSingle()
      }
}

extension Single where Element == Response {
    public func mapData<T: HandyJSON>(_ type: T.Type) -> Observable<BaseModel<T>?> {
        return self.asObservable().flatMap { (response) -> Observable<BaseModel<T>?> in
            return Observable.just(response.mapModel(T.self))
        }
    }
}

struct SessionNetworking {
    public func httpRequest(request_url:String,header: [String: String],completion: ((Any) -> Void)?) {
            guard let url = URL(string: request_url) else {
                return
            }
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            var headerValue = ["Content-Type":"application/json"]
            headerValue.merge(header) { paramaKeyValue, parama1 in
                return paramaKeyValue
            }
            config.httpAdditionalHeaders = headerValue
            config.timeoutIntervalForRequest = 30
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let session = URLSession(configuration: config)
            
            session.dataTask(with: urlRequest){
                (data,_,_) in
                if let resultData = data{
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: resultData, options:[.mutableContainers,.mutableLeaves])
                        completion?(jsonObject)
                    }catch{
                        completion?(NSError.init(domain: "net error", code: 201, userInfo: nil))
                    }
                }
            }.resume()
        }
}
