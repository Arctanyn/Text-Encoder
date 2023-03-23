//
//  HuffmanCodeViewModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

final class HuffmanCodeViewModel: TextEncoder {

    //MARK: Properties
    
    @Published var encodedText: String = ""
    
    @Published var characters: [Character] = []
    @Published var charactersInfo: [CharacterEncodeInfo] = []
    @Published var charactersProbalitiesList: [[Double]] = []
    
    @Published var q: Double = 0
    @Published var h: Double = 0
    
    private let text: String
    private var textEncoder = HuffmanTextEncoder()
    
    //MARK: - Initialization
    
    init(text: String) {
        self.text = text
    }
    
    //MARK: - Methods
    
    func encodeText() async {
        guard let result = await textEncoder.encode(text) else { return }
        let charactersInfo = result.info.charactersEncodeInfo
        
        async let averageQ = calculateAverageQ(from: result.info.PiQi)
        async let averagePLogP = calculateAvaragePLogP(from: result.info.PLogP)
        
        let sortedCharacters = result.info.characterProbalities.sorted(by: { $0.value > $1.value }).map { $0.key }
        let sortedProbalitiesList = result.probalitiesList.map { $0.sorted(by: >) }
        let summaryInfo = await (q: averageQ, h: averagePLogP)
        
        await MainActor.run {
            encodedText = result.encodedText
            self.charactersInfo = charactersInfo
            charactersProbalitiesList = result.probalitiesList
            characters = sortedCharacters
            charactersProbalitiesList = sortedProbalitiesList
            q = summaryInfo.q
            h = summaryInfo.h
        }
    }
}
