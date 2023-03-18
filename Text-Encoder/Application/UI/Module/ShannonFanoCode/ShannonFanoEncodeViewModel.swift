//
//  ShannonFanoEncodeViewModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation
import Combine

final class ShannonFanoEncodeViewModel: ObservableObject {
    
    //MARK: Properties
    
    @Published private(set) var encodedText = String()
    
    @Published private(set) var charactersInfo: [ShannonFanoCharacterInfo] = []
    
    @Published private(set) var q: Double = 0
    @Published private(set) var h: Double = 0
    
    private let text: String
    
    private lazy var textEncoder = ShannonFanoTextEncoder()
    
    //MARK: - Initialization
    
    init(text: String) {
        self.text = text
    }
    
    //MARK: - Methods
    
    func encodeText() async {
        guard let result = await textEncoder.encode(text) else { return }
        let charactersInfo = await createCharactersInfo(with: result.info)
        
        await MainActor.run(body: {
            encodedText = result.encodedText
            self.charactersInfo = charactersInfo
        })
    }
}

//MARK: - Private methods

private extension ShannonFanoEncodeViewModel {
    func createCharactersInfo(with shannonFanoInfo: ShannonFanoEncodeInfo) async -> [ShannonFanoCharacterInfo] {
        let sortedCodes = shannonFanoInfo.codes.sorted(by: { $0.value.count < $1.value.count })
        var charactersInfo = [ShannonFanoCharacterInfo]()
        
        for (character, code) in sortedCodes  {
            charactersInfo.append(
                .init(
                    char: character,
                    probability: shannonFanoInfo.characterProbalities[character] ?? 0,
                    code: code,
                    codeLenght: shannonFanoInfo.codeLengths[character] ?? 0,
                    PiQi: shannonFanoInfo.PiQi[character] ?? 0,
                    pLogP: shannonFanoInfo.PLogP[character] ?? 0
                )
            )
        }
        
        let q = await calculateAverageQ(from: shannonFanoInfo.PiQi)
        let h = await calculateAvaragePLogP(from: shannonFanoInfo.PLogP)
        
        await MainActor.run(body: {
            self.q = q
            self.h = h
        })
        
        return charactersInfo
    }
    
    private func calculateAverageQ(from PiQiDictionary: [Character: Double]) async -> Double {
        return PiQiDictionary.reduce(0.0) { $0 + $1.value }
    }
    
    private func calculateAvaragePLogP(from pLogPDictionary: [Character: Double]) async -> Double {
        return pLogPDictionary.reduce(0.0) { $0 + $1.value }
    }
}
