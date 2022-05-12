//
//  NavigatorService.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import RxSwift
import URLNavigator

public protocol NavigatorServiceType {
    var navigatorSubject: PublishSubject<NavigatorItemType> { get }
}

public protocol NavigatorItemType {

}
