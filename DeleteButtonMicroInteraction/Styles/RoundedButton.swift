//
//  RoundedButton.swift
//  DeleteButtonMicroInteraction
//
//  Created by George on 07/11/2025.
//

import SwiftUI

struct RoundedButton: ButtonStyle {
    let bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(height: 42)
            .padding(.horizontal, 16)
            .mask(RoundedRectangle(cornerRadius: .infinity))
            .background(bgColor, in: RoundedRectangle(cornerRadius: .infinity))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)
    }
}
