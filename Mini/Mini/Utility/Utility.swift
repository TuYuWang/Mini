//
//  Utility.swift
//  Utility
//
//  Created by Mac on 2017/12/28.
//  Copyright © 2017年 MYXG. All rights reserved.
//
import UIKit

public struct Utility<Base>{
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol UtilityCompatible {
    associatedtype CompatibleType
    var ul: CompatibleType { get }
}

extension UtilityCompatible {
    public var ul: Utility<Self> { get { return Utility(self) } }
}

extension String: UtilityCompatible {}
extension CGFloat: UtilityCompatible {}
extension Int: UtilityCompatible {}
extension Double: UtilityCompatible {}

extension Array {
    
    @discardableResult
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult:(Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map { next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
}

extension Sequence {
    
    @discardableResult
    func all(matching predicate: (Iterator.Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
    
    
}

extension Sequence where Iterator.Element: Hashable {
    //使用set来验证唯一性
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter{
            if seen.contains($0) {
                return false
            } else {
                seen.insert($0)
                return true
            }
        }
        
    }
}

extension Dictionary {
    
    mutating func merge<S>(_ other: S) where S: Sequence, S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
    
    //通过序列初始化
    init<S: Sequence>(_ Sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(Sequence)
    }
    
    //替换原有的value
    func mapValues<NewValue>(transform: (Value) -> NewValue) -> [Key: NewValue] {
        return Dictionary<Key, NewValue>(map {(key, value) in
            return (key, transform(value))
        })
    }

}


///

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        self.offset = string.startIndex
    }
    
    mutating func next() -> String? {
        guard offset < string.endIndex else { return nil }
        offset = string.index(after: offset)
        return String(string[string.startIndex..<offset])
    }
}

struct PrefixSequence: Sequence {
    let string: String
    
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
}

