//
//  HuffmanTreeNode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

class HuffmanTreeNode {
    let character: Character?
    let probality: Double
    var left: HuffmanTreeNode?
    var right: HuffmanTreeNode?
    
    init(character: Character?,
         probality: Double,
         left: HuffmanTreeNode? = nil,
         right: HuffmanTreeNode? = nil) {
        self.character = character
        self.probality = probality
        self.left = left
        self.right = right
    }
}

//MARK: - Methods

extension HuffmanTreeNode {
    func mapToDefaultBinaryTreeNode() -> BinaryTreeNode<Double> {
        let node = BinaryTreeNode(value: probality)
        
        if let left, let right {
            node.left = left.mapToDefaultBinaryTreeNode()
            node.right = right.mapToDefaultBinaryTreeNode()
        }
        
        return node
    }
}

extension HuffmanTreeNode: Comparable {
    static func < (lhs: HuffmanTreeNode, rhs: HuffmanTreeNode) -> Bool {
        lhs.probality < rhs.probality
    }
    
    static func == (lhs: HuffmanTreeNode, rhs: HuffmanTreeNode) -> Bool {
        lhs.probality == rhs.probality
    }
}
