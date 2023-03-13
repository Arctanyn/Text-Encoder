//
//  ShannonFanoEncodedTextViewModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation
import Combine

struct ShannonFanoCharInfo {
    let char: Character
    let probability: Double
    let code: String
    let codeLenght: Int
    let PiQi: Double
    let pLogP: Double
}

final class ShannonFanoEncodedTextViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published private(set) var encodedText = String()
    
    private let messageText: String
    
    private lazy var textEncoder = ShannonFanoTextEncoder()
    @Published private(set) var charactersInfo: [ShannonFanoCharInfo] = []
    
    @Published private(set) var averagePiQi: Double = 0
    @Published private(set) var averagePiLogPi: Double = 0
    
    //MARK: - Initialization
    
    init(messageText: String) {
        self.messageText = messageText
    }
    
    //MARK: - Methods
    
    func encodeText() async {
        guard let result = textEncoder.encode(messageText) else { return }
        let charactersInfo = await createCharactersInfo(with: result.info)
        
        await MainActor.run(body: {
            encodedText = result.encodedText
            self.charactersInfo = charactersInfo
        })
    }
}

//MARK: - Private methods

private extension ShannonFanoEncodedTextViewModel {
    func createCharactersInfo(with shannonFanoInfo: ShannonFanoEncodeInfo) async -> [ShannonFanoCharInfo] {
        let sortedCodes = shannonFanoInfo.codes.sorted(by: { $0.value.count < $1.value.count })
        var charInfo = [ShannonFanoCharInfo]()
        
        for code in sortedCodes  {
            charInfo.append(
                .init(
                    char: code.key,
                    probability: shannonFanoInfo.characterProbalities[code.key] ?? 0,
                    code: code.value,
                    codeLenght: shannonFanoInfo.codeLengths[code.key] ?? 0,
                    PiQi: shannonFanoInfo.PiQi[code.key] ?? 0,
                    pLogP: shannonFanoInfo.PLogP[code.key] ?? 0
                )
            )
        }
        
        let averagePiQi = await calculateAveragePiQi(from: shannonFanoInfo.PiQi)
        let averagePLogP = await calculateAvaragePLogP(from: shannonFanoInfo.PLogP)
        
        await MainActor.run(body: {
            self.averagePiQi = averagePiQi
            self.averagePiLogPi = averagePLogP
        })
        
        return charInfo
    }
    
    func calculateAveragePiQi(from PiQiDictionary: [Character: Double]) async -> Double {
        return PiQiDictionary.reduce(0) { $0 + $1.value } / Double(PiQiDictionary.count)
    }
    
    func calculateAvaragePLogP(from pLogPDictionary: [Character: Double]) async -> Double {
        return pLogPDictionary.reduce(0.0) { $0 + (-$1.value * log2($1.value)) } / Double(pLogPDictionary.count)
    }
}
