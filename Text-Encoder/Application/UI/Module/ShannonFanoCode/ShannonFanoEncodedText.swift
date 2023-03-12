//
//  ShannonFanoEncodedText.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoEncodedText: View {
    @ObservedObject var viewModel: ShannonFanoEncodedTextViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        CloseButton()
                        Spacer()
                    }
                    TitleText()
                    Divider()
                }
                .padding()
                
                List {
                    Section {
                        EncodedText()
                    } header: {
                        Text("Encoded Text")
                    }
                    
                    Section {
                        ForEach(viewModel.charactersInfo, id: \.char) { charInfo in
                            ShannonFanoCharValues(charInfo: charInfo)
                                .padding()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .task {
            await viewModel.encodeText()
        }
    }
    
    @ViewBuilder
    private func CloseButton() -> some View {
        Button("Close") {
            dismiss.callAsFunction()
        }
        .font(.headline)
        .tint(.primary)
    }
    
    @ViewBuilder
    private func TitleText() -> some View {
        VStack {
            Text("Encoded Text")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .padding(.top)
            Text("Shannon-Fano Method")
                .font(.system(.title, design: .serif, weight: .semibold))
        }
    }
    
    @ViewBuilder
    private func CopyButton() -> some View {
        Button {
            UIPasteboard.general.setValue(
                viewModel.encodedText,
                forPasteboardType: "public.plain-text"
            )
        } label: {
            HStack {
                Text("Copy")
                Image(systemName: "doc.on.doc")
            }
        }
        .tint(.gray)
        .fontWeight(.semibold)
        .padding([.top, .trailing])
    }
    
    @ViewBuilder
    private func EncodedText() -> some View {
        VStack(alignment: .leading, spacing: 20) {
//            CopyButton()

            Text(viewModel.encodedText)
                .multilineTextAlignment(.center)
                .fontWeight(.medium)
        }
        .padding()
    }
}

struct EncodingSteps_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoEncodedText(
            viewModel: ShannonFanoEncodedTextViewModel(
                messageText: "Hello"
            )
        )
    }
}
