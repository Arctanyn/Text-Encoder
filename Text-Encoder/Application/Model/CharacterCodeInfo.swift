//
//  ShannonFanoCharacterInfo.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 18.03.2023.
//

struct CharacterCodeInfo: Hashable {
    let char: Character
    let probability: Double
    let code: String
    let codeLenght: Int
    let PiQi: Double
    let pLogP: Double
}