//
//  File.swift
//
//
//  Created by Jax on 2020/3/28.
//

import Foundation

// MARK: -  HexSting -

public extension String {

    func toHexString() -> String {
        guard let data = data(using: .utf8) else {
            return ""
        }
        return data.toHexString()
    }

    /// 移除Ox前缀
    /// - Returns: 移除0x后的字符串
    func removeHexPrefix() -> String {
        if hasPrefix("0x") {
            return String(dropFirst(2))
        }
        return self
    }

    /// 增加0x前缀
    /// - Returns: 添加0x后的字符串
    func add0XHexPrefix() -> String {
        if hasPrefix("0x") {
            return self
        }
        return "0x" + self
    }

    /// hex格式字符串转Data类型
    /// - Returns: Data
    func hexStringToData() -> Data {
        var hex = replacingOccurrences(of: "0x", with: "")
        var data = Data()
        while !hex.isEmpty {
            let c: String = String(hex[..<hex.index(hex.startIndex, offsetBy: 2)])
            hex = String(hex[hex.index(hex.startIndex, offsetBy: 2)...])
            var ch: UInt32 = 0
            Scanner(string: c).scanHexInt32(&ch)
            var char = UInt8(ch)
            data.append(&char, count: 1)
        }
        return data
    }

    /// 16进制格式字符转十进制（不可Int最大值越界）
    /// - Returns: Int
    func hexStringToInt() -> Int {
        let hex = removeHexPrefix()
        let str = hex.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
            if i >= 65 { // A-Z 从65开始，但有初始值10，所以应该是减去55
                sum -= 7
            }
        }
        return sum
    }
}

// MARK: -  Encode - 编码

public extension String {

    /// URL编码
    func urlEncode() -> String {
        var resultStr = ""
        for (_, character) in enumerated() {

            // 注意字符串内 \ 是转义字符
            if "!#$%&’()*+,-./:;<=>?@[]^_`{|}~\\".contains(character) {
                let sub = "\(character)".toHexString()
                resultStr += "%" + sub.uppercased()
                continue
            }
            resultStr += "\(character)"
        }

        return resultStr
    }

    /// base64编码
    func base64Encode() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    /// base64解码
    func decodeBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

// MARK: - GBK

public extension String {

    /// 通过GBK编码的Data 生成字符串
    /// - Parameter gbkData: GBK编码的Data
    init?(gbkData: Data) {
        // 获取GBK编码, 使用GB18030是因为它向下兼容GBK
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        // 从GBK编码的Data里初始化NSString, 返回的NSString是UTF-16编码
        if let str = NSString(data: gbkData, encoding: encoding) {
            self = str as String
        } else {
            return nil
        }
    }

    /// GBK编码的Data
    var gbkData: Data {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (self as NSString).data(using: encoding)!
        return gbkData
    }
}

// MARK: -  Date

public extension String {
    /// 将当前日期字符串转换为字符串格式的日期
    /// 如果数据字符串格式和参数格式不一致，则返回nil。
    /// - Parameter format: date 格式的字符串
    func date(format: String, timezone: TimeZone = TimeZone(secondsFromGMT: 28800)!) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timezone
        return formatter.date(from: self)
    }
}
