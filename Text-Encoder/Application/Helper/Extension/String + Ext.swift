//
//  String + Ext.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 12.03.2023.
//

extension String {
    func findEachCharFrequency() -> [Character: Int] {
        var frequencies = [Character: Int]()
        for char in self {
            frequencies[char, default: 0] += 1
        }
        return frequencies
    }

    func findEachCharProbality() -> [Character: Double] {
        let frequencies = self.findEachCharFrequency()
        var probalities = [Character: Double]()
        
        for (char, frequency) in frequencies {
            probalities[char] = Double(frequency) / Double(self.count)
        }
        
        return probalities
    }
}
