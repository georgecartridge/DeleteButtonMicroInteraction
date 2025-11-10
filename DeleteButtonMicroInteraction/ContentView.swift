//
//  ContentView.swift
//  DeleteButtonMicroInteraction
//
//  Created by George on 07/11/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TimedActionButton(
                title: "Delete Account",
                cancelTitle: "Cancel Account",
            ) {
                print("Action triggered")
            }
        }
        .padding()
        .frame(minWidth: 400, minHeight: 400)
    }
}

#Preview {
    ContentView()
}
