//
//  HuffmanCode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import SwiftUI

struct HuffmanCode: View {
    
    @StateObject private var viewModel: HuffmanCodeViewModel
    
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
        .task {
            await viewModel.encodeText()
        }
    }
}

struct HuffmanCode_Previews: PreviewProvider {
    static var previews: some View {
        HuffmanCode(text: "Hello, World!")
    }
}
