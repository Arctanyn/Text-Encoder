//
//  TextEncoder.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

protocol TextEncoder: ObservableObject {
    var encodedText: String { get }
    var charactersInfo: [CharacterEncodeInfo] { get }
    var q: Double { get }
    var h: Double { get }
    
    func encodeText() async
}

extension TextEncoder {
    func calculateAverageQ(from PiQiDictionary: [Character: Double]) async -> Double {
        return PiQiDictionary.reduce(0.0) { $0 + $1.value }
    }
    
    func calculateAvaragePLogP(from pLogPDictionary: [Character: Double]) async -> Double {
        return pLogPDictionary.reduce(0.0) { $0 + $1.value }
    }
}
