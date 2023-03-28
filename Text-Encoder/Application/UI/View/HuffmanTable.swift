//
//  HuffmanTable.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import SwiftUI

struct HuffmanTable: View {
    let characters: [Character]
    let charactersProbalityList: [[Double]]
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 5) {
                ForEach(characters, id: \.self) { character in
                    ZStack {
                        Rectangle()
                            .fill(.primary)
                            .frame(width: 50, height: 50)
                        Text(character != " " ? String(character) : "_")
                            .foregroundColor(Color(.systemBackground))
                            .font(.headline)
                    }
                }
            }
            
            ForEach(charactersProbalityList, id: \.self) { sublist in
                VStack(spacing: 5) {
                    ForEach(sublist.map(UniqueValue.init)) { value in
                        ZStack {
                            Rectangle()
                                .fill(.secondary.opacity(0.2))
                                .frame(width: 60, height: 50)
                            Text(String(format: "%.3f", value.value))
                                .font(.headline)
                        }
                    }
                }
            }
        }
    }
}

struct HuffmanTable_Previews: PreviewProvider {
    static var previews: some View {
        HuffmanTable(
            characters: ["A", "B", "C", "D"],
            charactersProbalityList: [
                [0.2, 0.2, 0,2, 0.2],
                [0.2, 0.2, 0.2],
                [0.2, 0.2]
            ]
        )
    }
}
