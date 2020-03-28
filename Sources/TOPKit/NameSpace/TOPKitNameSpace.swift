//
//  File.swift
//
//
//  Created by Jax on 2020/3/28.
//
// 如果只想使用的话，把下面的源码拖到你的工程里，然后修改 top 为任何你想要的前缀即可。
import Foundation

/// 命名空间
public struct TOPKitNameSpace<T> {
    public let base: T
    public init(base: T) {
        self.base = base
    }
}

/// 命名空间协议
public protocol TOPKitNameSpaceProtocol {

    associatedtype TargetType
    var top: TOPKitNameSpace<TargetType> { get }
}

/// 扩展协议
public extension TOPKitNameSpaceProtocol {

    var top: TOPKitNameSpace<Self> {
        return TOPKitNameSpace<Self>(base: self)
    }
}
