//
//  HuffmanTextEncoder.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation


struct HuffmanTextEncoder: EncodeInfoProvider {
    
    private var characterProbalitiesList: [[Double]] = []
    
    //MARK: - Methods
    
    mutating func encode(_ text: String) async -> HuffmanEncode? {
        guard !text.isEmpty else { return nil }
        let probalities = text.findEachCharProbality()
        
        if let node = buildHuffmanTree(for: probalities) {
            let codes = buildCodes(node: node)
            let encodedText = text.encoded(with: codes)
            let info = provideEncodingInfo(with: codes, probalities: probalities)
            
            return HuffmanEncode(
                encodedText: encodedText,
                info: info,
                treeRootNode: node,
                probalitiesList: characterProbalitiesList
            )
        } else {
            return nil
        }
    }
}

//MARK: - Private methods

private extension HuffmanTextEncoder {
    mutating func buildHuffmanTree(for charactersProbalities: [Character: Double]) -> HuffmanTreeNode? {
        var nodes = charactersProbalities.map { character, probality in
            HuffmanTreeNode(character: character, probality: probality, left: nil, right: nil)
        }
        
        while nodes.count > 1 {
            nodes.sort(by: <)
            characterProbalitiesList.append(nodes.map({ $0.probality }))

            let leftNode = nodes.removeFirst()
            let rightNode = nodes.removeFirst()
            
            let totalProbality = leftNode.probality + rightNode.probality
            
            let parentNode = HuffmanTreeNode(
                character: nil,
                probality: totalProbality,
                left: leftNode,
                right: rightNode
            )
            
            nodes.append(parentNode)
        }
        
        return nodes.first
    }
    
    func buildCodes(node: HuffmanTreeNode, code: String = String()) -> [Character: String] {
        var codes = [Character: String]()
        
        if let character = node.character {
            codes[character] = code
        } else {
            if let left = node.left {
                codes.merge(buildCodes(node: left, code: code + "0"), uniquingKeysWith: { $1 })
            }
            
            if let right = node.right {
                codes.merge(buildCodes(node: right, code: code + "1"), uniquingKeysWith: { $1 })
            }
        }
        
        return codes
    }
}

