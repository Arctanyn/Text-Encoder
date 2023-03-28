//
//  UniqueValue.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 25.03.2023.
//

import Foundation

class UniqueValue<Value>: Identifiable {
    
    //MARK: Properties
    
    let value: Value
    
    //MARK: - Initialization
    
    init(_ value: Value) {
        self.value = value
    }
}
