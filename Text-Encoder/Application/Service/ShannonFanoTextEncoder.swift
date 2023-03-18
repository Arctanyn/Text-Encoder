//
//  ShannonFanoTextEncoder.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation

final class ShannonFanoTextEncoder {
    
    //MARK: - Methods
    
    func encode(_ message: String) async -> (encodedText: String, info: ShannonFanoEncodeInfo)? {
        guard !message.isEmpty else { return nil }
        
        let probalities = message.findEachCharProbality()
        let sortedProbalities = probalities.sorted { $0.value > $1.value }
            
        let codes = getCodes(probalities: sortedProbalities)
        
        let encodedMessage = convertMessageToCode(message, codes: codes)
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
    
    func convertMessageToCode(_ message: String, codes: [(Character, String)]) -> String {
        var encodedMessage = message
        for (character, code) in codes {
            encodedMessage = encodedMessage.replacingOccurrences(
                of: String(character),
                with: code
            )
        }
        return encodedMessage
    }
    
    func provideEncodingInfo(with codes: [(Character, String)],
                     probalities: [Character: Double]) -> ShannonFanoEncodeInfo {
        let codesDict = createCodeDict(with: codes)
        let codeLenghts = calculateLenghts(of: codesDict)
        return ShannonFanoEncodeInfo(
            characterProbalities: probalities,
            codes: codesDict,
            codeLengths: codeLenghts,
            PiQi: calculatePiQi(withProbalities: probalities, lenghts: codeLenghts),
            PLogP: calculatePLogP(withProbalities: probalities)
        )
    }
    
    func createCodeDict(with codes: [(Character, String)]) -> [Character: String] {
        var dict = [Character: String]()
        for code in codes {
            dict[code.0] = code.1
        }
        return dict
    }
    
    func calculateLenghts(of codes: [Character: String]) -> [Character: Int] {
        var lenghts = [Character: Int]()
        for code in codes {
            lenghts[code.key] = code.value.count
        }
        return lenghts
    }
    
    func calculatePiQi(withProbalities probalities: [Character: Double],
                       lenghts: [Character: Int]) -> [Character: Double] {
        guard probalities.count == lenghts.count else { return [:] }
        
        var PiQi = [Character: Double]()
        
        for probality in probalities {
            PiQi[probality.key] = probality.value * Double(lenghts[probality.key, default: 0])
        }
        
        return PiQi
    }
    
    func calculatePLogP(withProbalities probalities: [Character: Double]) -> [Character: Double] {
        var pLogP = [Character: Double]()
        
        for probality in probalities {
            pLogP[probality.key] = -probality.value * log2(probality.value)
        }
        
        return pLogP
    }
}
