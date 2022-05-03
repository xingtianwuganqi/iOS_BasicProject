//
//  BaseProtocol.swift
//  LoveCat
//
//  Created by jingjun on 2021/1/28.
//

import Foundation
import UIKit

public enum Paging {
    case refresh
    case next
}

/// 常用状态
public protocol StateProtocal {
    var isLoading: Bool {get set}
    var isRefreshing: Bool {get set}
    var endRefreshing: RefreshState? {get set}
    var netError: Bool {get set}
    var errorMsg: String? {get set}
    var page: Int {get set}
}

/// 刷新状态
public protocol RefreshViewControllerProtocal {
    func hasHeadRefresh() -> Bool
    func hasFooterRefresh() -> Bool
    // MARK: 重新请求新数据
    func retryNewData()
    // MARK: 上拉刷新和下拉加载调用
    func refreshNetWorking(page: Paging)
}
