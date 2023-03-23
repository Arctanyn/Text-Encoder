//
//  EncodeMethod.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

enum EncodeMethod: Identifiable, CaseIterable {
    case shannonFano
    case huffman
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .shannonFano:
            return "Shannon-Fano"
        case .huffman:
            return "Huffman"
        }
    }
}
