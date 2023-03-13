//
//  ShannonFanoCharValues.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

import SwiftUI

struct ShannonFanoCharValues: View {
    let charInfo: ShannonFanoCharInfo
    private let roundingDigitNumber: Double = 10000
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(charInfo.char != " " ? String(charInfo.char) : "Space")
                .font(.largeTitle)
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
                        round(roundingDigitNumber * charInfo.probability) / roundingDigitNumber
                    ))
                    
                    Text(charInfo.code)
                    Text(String(charInfo.codeLenght))
                    Text(String(
                        round(roundingDigitNumber * charInfo.PiQi) / roundingDigitNumber
                    ))
                    Text(String(
                        round(roundingDigitNumber * charInfo.pLogP) / roundingDigitNumber
                    ))
                }
                Spacer()
            }
            .font(.headline)
            .multilineTextAlignment(.trailing)
        }
    }
}

struct ShannonFanoCharValues_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoCharValues(charInfo: .init(char: "A", probability: 0.28, code: "1111", codeLenght: 4, PiQi: 0.54, pLogP: 0.38))
    }
}
