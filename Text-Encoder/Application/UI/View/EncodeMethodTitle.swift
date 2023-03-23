//
//  EncodeMethodTitle.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 23.03.2023.
//

import SwiftUI

struct EncodeMethodTitle: View {
    let method: EncodeMethod
    
    var body: some View {
        Text(method.title)
            .font(.system(.title, design: .serif, weight: .semibold))
    }
}

struct EncodeMethodTitle_Previews: PreviewProvider {
    static var previews: some View {
        EncodeMethodTitle(method: .shannonFano)
    }
}
