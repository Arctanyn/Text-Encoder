//
//  TextEncode.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct TextEncode: View {
    @State private var messageText = ""
    @State private var currentEncodeMethod = EncodeMethod.shannonFano
    
    @State private var isEncodedPresented = false
    @FocusState private var messageTextInFocus
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Text Encode")
                    .font(.system(.largeTitle, design: .serif, weight: .semibold))
                
                Picker("Encode method", selection: $currentEncodeMethod) {
                    ForEach(EncodeMethod.allCases) { encodeMethod in
                        Text(encodeMethod.title)
                    }
                }
                .tint(.primary)
                
                Spacer()
                
                messageTextEditor
                encodeButton
            }
            .padding()
            .navigationDestination(isPresented: $isEncodedPresented) {
                let textToEncode = messageText.trimmingCharacters(in: .whitespaces)
                
                switch currentEncodeMethod {
                case .shannonFano:
                    ShannonFanoCode(text: textToEncode)
                case .huffman:
                    HuffmanCode(text: textToEncode)
                }
            }
            .onAppear {
                messageTextInFocus = true
            }
        }
        .tint(.primary)
    }
    
    private var messageTextEditor: some View {
        VStack {
            Text("Message Text")
                .foregroundColor(.secondary)
                .font(.headline)
            
            TextEditor(text: $messageText)
                .tint(.primary)
                .scrollContentBackground(.hidden)
        }
        .padding()
        .background(Color(.tertiarySystemFill))
        .cornerRadius(10)
        .focused($messageTextInFocus)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    messageTextInFocus = false
                }
                .font(.headline)
            }
        }
    }
    
    private var encodeButton: some View {
        Button {
            isEncodedPresented.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                Text("Encode")
                    .font(.headline)
                    .foregroundColor(Color(.tertiarySystemBackground))
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
        }
        .tint(.primary)
        .disabled(!isEncodeButtonEnable)
        .padding()
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
