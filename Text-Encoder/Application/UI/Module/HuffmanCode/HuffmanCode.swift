//
//  HuffmanCode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import SwiftUI

struct HuffmanCode: View {
    
    @StateObject private var viewModel: HuffmanCodeViewModel
    @State private var isLoading = true
    
    init(text: String) {
        _viewModel = StateObject(wrappedValue: HuffmanCodeViewModel(text: text))
    }

    var body: some View {
        List {
            Section() {
                VStack(alignment: .center) {
                    EncodeMethodTitle(method: .huffman)
                }
            }
            .listRowBackground(Color.clear)
            
            Section("Encoded Text") {
                Text(viewModel.encodedText)
                    .multilineTextAlignment(.leading)
            }
            
            Section("Huffman Table") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HuffmanTable(
                        characters: viewModel.characters,
                        charactersProbalityList: viewModel.charactersProbalitiesList
                    )
                }
            }
            
            Section("Huffman Binary Tree") {
                if let rootNode = viewModel.treeRoot {
                    ScrollView(.horizontal) {
                        BinaryTreeView(tree: rootNode) { nodeValue in
                            treeNode(value: nodeValue.value)
                        }
                    }
                }
            }
            
            Section("Characters Info") {
                ForEach(viewModel.charactersInfo, id: \.self) { characterInfo in
                    CharacterEncode(info: characterInfo)
                }
            }
            
            Section("Summary") {
                EncodeSummary(
                    q: viewModel.q,
                    h: viewModel.h
                )
            }
        }
        .id(UUID())
        .task {
            await viewModel.encodeText()
        }
    }
    
    private func treeNode(value: Double) -> some View {
        Text(String(format: "%.3f", value))
            .font(.headline)
            .foregroundColor(Color(.systemBackground))
            .frame(width: 60, height: 60)
            .background(Circle().fill(.primary))
            .padding(5)
    }
    
    private func huffmanTree(rootNode: BinaryTreeNode<UniqueValue<Double>>) async -> some View {
        let tree = BinaryTreeView(tree: rootNode) { value in
            self.treeNode(value: value.value)
        }
        isLoading = false
        return tree
    }
}

struct HuffmanCode_Previews: PreviewProvider {
    static var previews: some View {
        HuffmanCode(text: "Hello, World!")
    }
}
