//
//  Line.swift
//  Text-Encoder
//
//  Created by Малиль Дугулюбгов on 25.03.2023.
//

import SwiftUI

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}
