//
//  CollectDict.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 25.03.2023.
//

import SwiftUI

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    typealias Value = [Key: Value]
    
    static var defaultValue: [Key : Value] { return [:] }
    
    static func reduce(value: inout [Key : Value], nextValue: () -> [Key : Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
