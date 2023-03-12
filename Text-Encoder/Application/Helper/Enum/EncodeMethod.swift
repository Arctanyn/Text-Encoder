//
//  EncodeMethod.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

enum EncodeMethod: Identifiable, CaseIterable {
    case shannonFanoSets
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .shannonFanoSets:
            return "Shannon-Fano Method"
        }
    }
}
