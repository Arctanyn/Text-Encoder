//
//  ShannonFanoEncodeInfo.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation

struct ShannonFanoEncodeInfo {
    let characterProbalities: [Character: Double]
    let codes: [Character: String]
    let codeLengths: [Character: Int]
    let PiQi: [Character: Double]
    let PLogP: [Character: Double]
}
