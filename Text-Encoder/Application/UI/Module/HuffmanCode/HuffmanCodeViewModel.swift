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
    @Published var charactersProbalitiesList = Array<[Double]>()
    
    @Published var q: Double = 0
    @Published var h: Double = 0
    
    @Published var treeRoot: BinaryTreeNode<UniqueValue<Double>>?
    
    private let text: String
    private var textEncoder = HuffmanTextEncoder()
    
    //MARK: - Initialization
    
    init(text: String) {
        self.text = text
    }
    
    //MARK: - Methods
    
    func encodeText() async {
        guard let result = await textEncoder.encode(text) else { return }
        let charactersEncodeInfo = result.info.charactersEncodeInfo

        let sortedCharacters = result.info.characterProbalities.sorted(by: { $0.value > $1.value }).map { $0.key }
        let sortedProbalitiesList = result.probalitiesList.map { $0.sorted(by: >) }
        
        let binaruTreeNode = await createBinaryTreeNode(with: result.treeRootNode)
        let summaryInfo = await getSummaryInfo(PiQi: result.info.PiQi, PLogP: result.info.PLogP)
        
        await MainActor.run {
            encodedText = result.encodedText
            charactersInfo = charactersEncodeInfo
            charactersProbalitiesList = result.probalitiesList
            characters = sortedCharacters
            charactersProbalitiesList = sortedProbalitiesList
            treeRoot = binaruTreeNode
            q = summaryInfo.q
            h = summaryInfo.h
        }
    }
}

//MARK: - Private methods

private extension HuffmanCodeViewModel {
    func getSummaryInfo(PiQi: [Character: Double], PLogP: [Character: Double]) async -> (q: Double, h: Double) {
        async let averageQ = calculateAverageQ(from: PiQi)
        async let averagePLogP = calculateAvaragePLogP(from: PLogP)
        return await (q: averageQ, h: averagePLogP)
    }
    
    func createBinaryTreeNode(with huffmanNode: HuffmanTreeNode) async -> BinaryTreeNode<UniqueValue<Double>> {
        let binaryTreeNode = huffmanNode.mapToDefaultBinaryTreeNode()
        return binaryTreeNode.map(UniqueValue.init)
    }
}
