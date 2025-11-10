//
//  TimedActionButton.swift
//  DeleteButtonMicroInteraction
//
//  Created by George on 07/11/2025.
//

import SwiftUI

struct TimedActionButton: View {
    let title: String
    let cancelTitle: String
    let onSubmit: () -> Void
    
    @State private var startCountdown = false
    @State private var timeRemaining = 10
    @State private var timer: Timer?
    
    private var buttonOpacity: Double {
        let isButtonHidden = !startCountdown && timeRemaining == 0
        
        if startCountdown {
            return 0.1
        } else if isButtonHidden {
            return 0.5
        } else {
            return 1
        }
    }
    
    var body: some View {
        Button {
            startCountdown.toggle()
            
            if timeRemaining == 0 {
                resetTimer()
            } else if startCountdown {
                startTimer()
            } else {
                resetTimer()
            }
        } label: {
            HStack {
                if startCountdown {
                    Image(systemName: "arrow.uturn.backward.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(.red)
                }
                
                StaggeredText(startCountdown ? cancelTitle : title)
                    .foregroundStyle(startCountdown ? .red : .white)
                
                if startCountdown {
                    Text(String(timeRemaining))
                        .contentTransition(.numericText(countsDown: true))
                        .font(.system(size: 12))
                        .frame(width: 32, height: 24)
                        .background(.red, in: RoundedRectangle(cornerRadius: .infinity))
                        .animation(.bouncy, value: timeRemaining)
                }
            }
        }
        .buttonStyle(RoundedButton(bgColor: .red.opacity(buttonOpacity)))
        .disabled(timeRemaining == 0)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
            
            if timeRemaining == 0 {
                timer?.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        startCountdown.toggle()
                    }
                }
                
                onSubmit()
            }
        }
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timeRemaining = 10
        startCountdown = false
    }
}

#Preview {
    VStack {
        TimedActionButton(
            title: "Delete Account",
            cancelTitle: "Cancel Account",
            onSubmit: {
                print("Action triggered")
            }
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
