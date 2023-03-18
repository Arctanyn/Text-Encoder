//
//  ShannonFanoEncode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoEncode: View {
    @ObservedObject var viewModel: ShannonFanoEncodeViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                Text("Shannon-Fano Method")
                    .font(.system(.title, design: .serif, weight: .semibold))
            }
            .listRowBackground(Color.clear)
            Section("Encoded Text") {
                Text(viewModel.encodedText)
                    .multilineTextAlignment(.leading)
            }
            
            Section("Characters Info") {
                ForEach(viewModel.charactersInfo, id: \.hashValue) { characterInfo in
                    ShannonFanoCharacter(info: characterInfo)
                }
            }
            
            Section("Summary") {
                ShannonFanoSummary(
                    q: viewModel.q,
                    h: viewModel.h
                )
            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.encodeText()
        }
    }
}

struct EncodingSteps_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoEncode(
            viewModel: ShannonFanoEncodeViewModel(
                text: "Hello"
            )
        )
    }
}
