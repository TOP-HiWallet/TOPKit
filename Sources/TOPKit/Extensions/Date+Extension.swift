//
//  File.swift
//
//
//  Created by Jax on 2020/3/28.
//

import Foundation

extension Date: TOPKitNameSpaceProtocol {}

public extension TOPKitNameSpace where T == Date {

    /// 获取带有特定格式的字符串
    /// - Parameter dateFormatter: "yyyy-MM-dd HH:mm" 格式的字符串
    /// - Parameter timezone: 默认时区为北京
    func string(custom dateFormatter: String, timezone: TimeZone = TimeZone(secondsFromGMT: 28800)!) -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormatter
        format.timeZone = timezone
        return format.string(from: base)
    }
}
