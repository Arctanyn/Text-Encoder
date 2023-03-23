//
//  EncodeInfoProvider.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

protocol EncodeInfoProvider { }

extension EncodeInfoProvider {
    func provideEncodingInfo(with codes: [Character: String],
                     probalities: [Character: Double]) -> TextEncodeInfo {
        let codeLenghts = calculateLenghts(of: codes)
        return TextEncodeInfo(
            characterProbalities: probalities,
            codes: codes,
            codeLengths: codeLenghts,
            PiQi: calculatePiQi(withProbalities: probalities, lenghts: codeLenghts),
            PLogP: calculatePLogP(withProbalities: probalities)
        )
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
