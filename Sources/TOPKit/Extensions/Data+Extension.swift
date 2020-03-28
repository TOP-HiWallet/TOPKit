//
//  File.swift
//
//
//  Created by Jax on 2020/3/28.
//

import Foundation
extension Data: TOPKitNameSpaceProtocol {}
public extension TOPKitNameSpace where T == Data {

    /// byte数组
    var bytes: [UInt8] {
        return Array(base)
    }

    /// 转hex字符串
    /// - Returns: hex字符串
    func toHexString() -> String {
        return bytes.toHexStr()
    }
}

public extension Data {
    /// 通过hex字符串初始化Data
    /// - Parameter hex: hex格式字符串
    init(hexStr: String) {
        self.init([UInt8](hexStr: hexStr))
    }
}
