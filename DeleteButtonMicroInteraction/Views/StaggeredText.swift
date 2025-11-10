//
//  StaggeredText.swift
//  DeleteButtonMicroInteraction
//
//  Created by George on 07/11/2025.
//

import SwiftUI

struct StaggeredText: View {
    let text: String
    
    @State private var previousText: String
    @State private var newText: String
    
    init(_ text: String) {
        self.text = text
        self.newText = text
        self.previousText = ""
    }
    
    var body: some View {
        ZStack {
            Text(previousText)
                .contentTransition(.numericText())
            
            Text(newText)
                .contentTransition(.numericText())
        }
        .onChange(of: text) { oldValue, newValue in
            previousText = oldValue
            newText = String(repeating: " ", count: newValue.count)
            
            withAnimation {
                newText = newValue
                previousText = String(repeating: " ", count: oldValue.count)
            }
        }
    }
}

#Preview {
    @Previewable @State var index = 0
    
    var text = ["Your text", "Another text"]
    
    VStack {
        StaggeredText(text[index])
        
        Button("Toggle") {
            index = (index + 1) % text.count
        }
    }
    .frame(width: 400, height: 400)
}
