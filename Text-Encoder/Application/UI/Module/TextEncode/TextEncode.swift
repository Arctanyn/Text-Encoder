//
//  TextEncode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct TextEncode: View {
    @StateObject private var viewModel = TextEncodeViewModel()
    @State private var messageText = ""
   
    @State private var isEncodePresented = false
    
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            
            VStack {
                Text("Text Encode")
                    .font(.system(.largeTitle, design: .serif, weight: .bold))
                    .padding(.top)
                
                Divider()
                
                Picker(selection: $viewModel.encodeMethod) {
                    ForEach(EncodeMethod.allCases) { encodeMethod in
                        Text(encodeMethod.title)
                    }
                } label: {
                    Text("Encode method")
                }
                .tint(.primary)
                
                VStack {
                    MessageTextEdidor(
                        text: $messageText,
                        title: "Message Text"
                    )
                    
                    EncodeButton()
                        .padding()
                }
                .padding()
            }
        }
        
    }
    
    @ViewBuilder
    private func EncodeButton() -> some View {
        Button {
            isEncodePresented.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                Text("Encode")
                    .font(.headline)
                    .foregroundColor(Color(.systemBackground))
            }
        }
        .tint(.primary)
        .frame(width: 150, height: 45)
        .disabled(!isEncodeButtonEnable)
        .fullScreenCover(isPresented: $isEncodePresented) {
            ShannonFanoEncodedText(
                viewModel: ShannonFanoEncodedTextViewModel(
                    messageText: messageText
                )
            )
        }
    }
    
    @ViewBuilder
    private func MessageTextEdidor(text: Binding<String>, title: String) -> some View {
        ZStack {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                TextEditor(text: text)
                    .tint(.primary)
                    .padding()
            }
        }
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

//MARK: - Private methods

private extension TextEncode {
    var isEncodeButtonEnable: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

struct TextEncode_Previews: PreviewProvider {
    static var previews: some View {
        TextEncode()
    }
}
