//
//  MessageBar.swift
//  ChatApp
//
//  Created by Michal Ukropec on 17/04/2025.
//

import SwiftUI

struct MessageBar: View {
    @EnvironmentObject var appState: AppState
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField("Ask AI", text: $appState.messageBarText)
            .focused($isFocused)
            .textFieldStyle(PlainTextFieldStyle())
            .onSubmit {
                if appState.currentThread != "" {
                    appState.addMessage(appState.messageBarText, isOwn: true)
                    appState.messageBarText = ""

                    appState.sendToOpenAI(apiKey: "sk-...") { response in
                        DispatchQueue.main.async {
                            if let reply = response {
                                appState.addMessage(reply, isOwn: false)
                            }
                        }
                    }
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(
                        appState.messageBarFocus
                            ? Color.accentColor : Color.gray.opacity(0.1),
                        lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(.thinMaterial)
            )
            .animation(
                .easeInOut(duration: 0.2), value: appState.messageBarFocus
            )
            .onChange(of: isFocused) {
                appState.messageBarFocus = isFocused
            }
            .onChange(of: appState.messageBarFocus) {
                isFocused = appState.messageBarFocus
            }
            .onAppear {
                isFocused = false
                appState.messageBarFocus = false
            }
    }
}

#Preview {
    MessageBar()
        .environmentObject(AppState())
}
