//
//  ShannonFanoCode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoCode: View {
    @ObservedObject var viewModel: ShannonFanoEncodeViewModel
    
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
        .task {
            await viewModel.encodeText()
        }
    }
}

struct EncodingSteps_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShannonFanoCode(
                viewModel: ShannonFanoEncodeViewModel(
                    text: "Hello"
                )
            )
        }
    }
}
