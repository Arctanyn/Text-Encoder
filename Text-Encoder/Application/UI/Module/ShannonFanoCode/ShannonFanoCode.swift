//
//  ShannonFanoCode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoCode: View {
    @StateObject private var viewModel: ShannonFanoEncodeViewModel
    
    init(text: String) {
        _viewModel = StateObject(
            wrappedValue: ShannonFanoEncodeViewModel(text: text)
        )
    }
    
    var body: some View {
        List {
            Section() {
                VStack(alignment: .center) {
                    EncodeMethodTitle(method: .shannonFano)
                }
            }
            .listRowBackground(Color.clear)
            
            Section("Encoded Text") {
                Text(viewModel.encodedText)
                    .multilineTextAlignment(.leading)
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

struct EncodingSteps_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShannonFanoCode(text: "Hello, World!")
        }
    }
}
