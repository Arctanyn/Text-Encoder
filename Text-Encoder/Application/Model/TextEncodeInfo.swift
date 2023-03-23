//
//  TextEncodeInfo.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

struct TextEncodeInfo {
    let characterProbalities: [Character: Double]
    let codes: [Character: String]
    let codeLengths: [Character: Int]
    let PiQi: [Character: Double]
    let PLogP: [Character: Double]
    
    var charactersEncodeInfo: [CharacterEncodeInfo] {
        let sortedCodes = codes.sorted(by: { $0.value.count < $1.value.count })
        
        var charactersInfo = [CharacterEncodeInfo]()
        
        for (character, code) in sortedCodes  {
            charactersInfo.append(
                .init(
                    char: character,
                    probability: characterProbalities[character] ?? 0,
                    code: code,
                    codeLenght: codeLengths[character] ?? 0,
                    PiQi: PiQi[character] ?? 0,
                    pLogP: PLogP[character] ?? 0
                )
            )
        }
        
        return charactersInfo
    }
}
