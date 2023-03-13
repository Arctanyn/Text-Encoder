//
//  ShannonFanoSummary.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 13.03.2023.
//

import SwiftUI

struct ShannonFanoSummary: View {
    let averagePiQi: Double
    let averagePiLogPi: Double
    private let roundingDigitNumber: Double = 10000
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Average Pi*Qi:")
                        .foregroundColor(.secondary)
                    Text(String(round(roundingDigitNumber * averagePiQi) / roundingDigitNumber))
                        .fontWeight(.semibold)
                }
                HStack {
                    Text("Average -Pi*Log(Pi):")
                        .foregroundColor(.secondary)
                    Text(String(round(roundingDigitNumber * averagePiLogPi) / roundingDigitNumber))
                        .fontWeight(.semibold)
                }
            }
            
            if (round(10 * averagePiQi) / 10) == (round(10 * averagePiLogPi) / 10) {
                Text("The code is optimal")
            } else {
                Text("The code is not optimal")
            }
        }
        .font(.title2)
        .padding()
    }
}

struct ShannonFanoSummary_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoSummary(averagePiQi: 0.5, averagePiLogPi: 0.51)
    }
}
