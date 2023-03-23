//
//  BinaryTreeNode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import Foundation

class BinaryTreeNode {
    let character: Character?
    let probality: Double
    var left: BinaryTreeNode?
    var right: BinaryTreeNode?
    
    init(character: Character?,
         probality: Double,
         left: BinaryTreeNode? = nil,
         right: BinaryTreeNode? = nil) {
        self.character = character
        self.probality = probality
        self.left = left
        self.right = right
    }
}

extension BinaryTreeNode: Comparable {
    static func < (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        lhs.probality < rhs.probality
    }
    
    static func == (lhs: BinaryTreeNode, rhs: BinaryTreeNode) -> Bool {
        lhs.probality == rhs.probality
    }
}
