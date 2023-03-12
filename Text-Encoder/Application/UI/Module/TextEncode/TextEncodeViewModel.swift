//
//  TextEncodeViewModel.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import Foundation

final class TextEncodeViewModel: ObservableObject {
    @Published var encodeMethod: EncodeMethod = .shannonFanoSets
    @Published var encodedText: String = ""
    
    var isEncodeButtonEnable: Bool {
        encodedText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
