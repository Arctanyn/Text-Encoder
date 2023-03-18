//
//  ShannonFanoSummary.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 13.03.2023.
//

import SwiftUI

struct ShannonFanoSummary: View {
    let q: Double
    let h: Double
    
    private let roundingDigitNumber: Double = 10000
    
    private var valuesAreEqual: Bool {
        q.rounded() == h.rounded()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Average q:")
                        .foregroundColor(.secondary)
                    Text(String(round(roundingDigitNumber * q) / roundingDigitNumber))
                }
                HStack {
                    Text("Average H:")
                        .foregroundColor(.secondary)
                    Text(String(round(roundingDigitNumber * h) / roundingDigitNumber))
                }
            }
            
            Text(valuesAreEqual ? "The code is optimal" : "The code is not optimal")
        }
        .font(.headline)
        .padding()
    }
}

struct ShannonFanoSummary_Previews: PreviewProvider {
    static var previews: some View {
        ShannonFanoSummary(q: 0.5, h: 0.51)
    }
}
