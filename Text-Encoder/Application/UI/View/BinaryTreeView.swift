//
//  BinaryTreeView.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 25.03.2023.
//

import SwiftUI

struct BinaryTreeView<Value: Identifiable, V: View> : View {
    typealias Key = CollectDict<Value.ID, Anchor<CGPoint>>
    
    let tree: BinaryTreeNode<Value>
    let nodeView: (Value) -> V
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            nodeView(tree.value)
                .anchorPreference(key: Key.self, value: .center) { anchor in
                    [self.tree.value.id: anchor]
                }
            LazyHStack {
                HStack(alignment: .bottom, spacing: 5) {
                    ForEach(tree.children, id: \.value.id) { node in
                        HStack {
                            BinaryTreeView(tree: node, nodeView: nodeView)
                        }
                    }
                }
            }
        }
        .backgroundPreferenceValue(Key.self, { (centers: [Value.ID: Anchor<CGPoint>]) in
            GeometryReader { geometry in
                ForEach(tree.children, id: \.value.id) { node in
                    if let fromId = centers[tree.value.id], let toId = centers[node.value.id] {
                        Line(
                            from: geometry[fromId],
                            to: geometry[toId]
                        )
                        .stroke()
                    }
                }
            }
        })
        .padding(5)
    }
}

struct BinaryTreeView_Previews: PreviewProvider {
    
    static let tree = BinaryTreeNode(
        value: 1.0,
        left: BinaryTreeNode(
            value: 0.42,
            left: BinaryTreeNode(value: 0.22),
            right: BinaryTreeNode(value: 0.2)
        ),
        right: BinaryTreeNode(
            value: 0.58,
            left: BinaryTreeNode(
                value: 0.32,
                left: BinaryTreeNode(value: 0.16),
                right: BinaryTreeNode(value: 0.16)
            ),
            right: BinaryTreeNode(value: 0.26)
        )
    )
    
    static var previews: some View {
        BinaryTreeView(tree: tree.map(UniqueValue.init), nodeView: { nodeValue in
            ZStack {
                Text(String(format: "%.3f", nodeValue.value))
                    .font(.headline)
                    .frame(width: 60, height: 60)
                    .background(Circle().stroke())
                    .background(Circle().fill(Color(.systemBackground)))
                    .padding(10)
            }
        })
    }
}
