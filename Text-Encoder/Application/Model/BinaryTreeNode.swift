//
//  TreeNodeDisplayModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 25.03.2023.
//

class BinaryTreeNode<T>: Identifiable {
    
    //MARK: Properties
    
    var value: T
    var left: BinaryTreeNode<T>?
    var right: BinaryTreeNode<T>?
    
    var children: [BinaryTreeNode<T>] {
        [left, right].compactMap { $0 }
    }
    
    //MARK: - Initialization
    
    init(value: T, left: BinaryTreeNode<T>? = nil, right: BinaryTreeNode<T>? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

//MARK: - Methods

extension BinaryTreeNode {
    func map<B>(_ transform: (T) -> B) -> BinaryTreeNode<B> {
        let node = BinaryTreeNode<B>(value: transform(value))
        
        if let left, let right {
            node.left = left.map(transform)
            node.right = right.map(transform)

        }
        
        return node
    }
}
