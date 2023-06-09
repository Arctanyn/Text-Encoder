//
//  ShannonFanoEncodeViewModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation
import Combine

final class ShannonFanoEncodeViewModel: TextEncoder {
    
    //MARK: Properties
    
    @Published var encodedText: String = ""
    @Published var charactersInfo: [CharacterEncodeInfo] = []
    
    @Published var q: Double = 0
    @Published var h: Double = 0
    
    private let text: String
    private let textEncoder = ShannonFanoTextEncoder()
    
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
        
        let summaryInfo = await (q: averageQ, h: averagePLogP)

        await MainActor.run {
            encodedText = result.encodedText
            self.charactersInfo = charactersInfo
            q = summaryInfo.q
            h = summaryInfo.h
        }
    }
}
