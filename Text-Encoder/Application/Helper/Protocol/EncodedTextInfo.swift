//
//  EncodedTextInfo.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

protocol EncodedTextInfo: ObservableObject {
    var encodedText: String { get }
    var charactersInfo: [CharacterCodeInfo] { get }
    var q: Double { get }
    var h: Double { get }
}
