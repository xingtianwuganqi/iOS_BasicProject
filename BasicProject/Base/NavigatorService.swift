//
//  NavigatorService.swift
//  LoveCat
//
//  Created by jingjun on 2020/12/16.
//

import RxSwift
import URLNavigator

protocol NavigatorServiceType {
    var navigatorSubject: PublishSubject<NavigatorItem> { get }
}

enum NavigatorItem {

}
