//
//  File.swift
//
//
//  Created by Jax on 2020/3/28.
//

import Foundation

public extension Array {
    init(reserveCapacityValue: Int) {
        self = [Element]()
        reserveCapacity(reserveCapacityValue)
    }

    var slice: ArraySlice<Element> {
        return self[self.startIndex ..< self.endIndex]
    }
}

public extension Array where Element == UInt8 {

    /// 通过hex字符串初始化数组
    /// - Parameter hex: hex字符串
    init(hexStr: String) {
        self.init(reserveCapacityValue: hexStr.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = hexStr.hasPrefix("0x") ? 2 : 0
        for char in hexStr.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48, char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            append(b)
        }
    }

    /// 数组转hex字符串
    /// - Returns: hex字符串
    func toHexStr() -> String {
        return `lazy`.reduce("") {
            var s = String($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            return $0 + s
        }
    }
}
