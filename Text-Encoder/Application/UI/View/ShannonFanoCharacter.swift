//
//  ShannonFanoCharacter.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoCharacter: View {
    let info: CharacterCodeInfo
    private let roundingDigitNumber: Double = 10000
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(info.char != " " ? String(info.char) : "Space")
                .font(.title)
                .fontWeight(.semibold)
                .padding()
            
            HStack(spacing: 20) {
                Spacer()
                VStack(alignment: .trailing, spacing: 10.0) {
                    Text("Probality:")
                    Text("Code:")
                    Text("Code Lenght:")
                    Text("Pi*Qi:")
                    Text("-Pi*log(Pi):")
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 10.0) {
                    Text(String(
                        round(roundingDigitNumber * info.probability) / roundingDigitNumber
                    ))
                    
                    Text(info.code)
                    Text(String(info.codeLenght))
                    Text(String(
                        round(roundingDigitNumber * info.PiQi) / roundingDigitNumber
                    ))
                    Text(String(
                        round(roundingDigitNumber * info.pLogP) / roundingDigitNumber
                    ))
                }
                Spacer()
            }
            .font(.headline)
            .multilineTextAlignment(.trailing)
        }
        .padding()
    }
}

struct ShannonFanoCharValues_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoCharacter(info: .init(char: "A", probability: 0.28, code: "1111", codeLenght: 4, PiQi: 0.54, pLogP: 0.38))
    }
}
