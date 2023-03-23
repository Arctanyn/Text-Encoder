//
//  ShannonFanoTextEncoder.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation

struct ShannonFanoTextEncoder: EncodeInfoProvider {
    
    //MARK: - Methods
    
    func encode(_ text: String) async -> (encodedText: String, info: TextEncodeInfo)? {
        guard !text.isEmpty else { return nil }
        
        let probalities = text.findEachCharProbality()
        let sortedProbalities = probalities.sorted { $0.value > $1.value }
            
        let codes = createCodeDict(with: getCodes(probalities: sortedProbalities))
        
        let encodedMessage = text.encoded(with: codes)
        let encodingInfo = provideEncodingInfo(with: codes, probalities: probalities)
        
        return (encodedMessage, encodingInfo)
    }
}

//MARK: - Private methods

private extension ShannonFanoTextEncoder {
    func getCodes(probalities: [Dictionary<Character, Double>.Element],
                  codes: [Dictionary<Character, String>.Element] = []) -> [Dictionary<Character, String>.Element] {
        guard probalities.count > 1 else { return codes }
        
        var newCodes = codes
        
        var index = 0
        var jointProbality = 0.0
        let totalProbality = probalities.reduce(0) { $0 + $1.value }
        
        for probality in probalities {
            if jointProbality >= totalProbality / 2 {
                if let codeIndex = (newCodes.firstIndex { $0.key == probality.key }) {
                    var code = newCodes.remove(at: codeIndex)
                    code.value += "0"
                    newCodes.insert(code, at: codeIndex)
                } else {
                    newCodes.append((probality.key, "0"))
                }
            } else {
                index += 1
                jointProbality += probality.value
                
                if let codeIndex = (newCodes.firstIndex { $0.key == probality.key }) {
                    var code = newCodes.remove(at: codeIndex)
                    code.value += "1"
                    newCodes.insert(code, at: codeIndex)
                } else {
                    newCodes.append((probality.key, "1"))
                }
            }
        }
        
        let topCharactersSet = Array(probalities[0..<index])
        let bottomCharactersSet = Array(probalities[index..<probalities.count])
        
        let topCodes = getCodes(probalities: topCharactersSet, codes: Array(newCodes[0..<index]))
        let bottomCodes = getCodes(probalities: bottomCharactersSet, codes: Array(newCodes[index..<newCodes.count]))
        
        return topCodes + bottomCodes
    }
    
    func createCodeDict(with codes: [(Character, String)]) -> [Character: String] {
        var dict = [Character: String]()
        for code in codes {
            dict[code.0] = code.1
        }
        return dict
    }
}
