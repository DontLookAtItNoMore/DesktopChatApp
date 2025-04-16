//
//  ChatView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var appState: AppState
    @FocusState private var isFocused: Bool

    let screenWidth = NSScreen.main?.frame.width

    var Header: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .padding(.horizontal, 24)
            .background(.ultraThickMaterial)

            Rectangle()
                .fill(Color.black)
                .frame(height: 1)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }

    var Input: some View {
        HStack {
            TextField("Message AI", text: $appState.messageText)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 999, style: .continuous)
                        .stroke(
                            isFocused
                                ? Color.accentColor
                                : Color.gray.opacity(0.1),
                            lineWidth: 1)
                )
                .background(
                    RoundedRectangle(cornerRadius: 999, style: .continuous)
                        .fill(.thinMaterial)
                )
                .padding()
                .onTapGesture {
                    isFocused = true
                }
                .animation(.easeInOut(duration: 0.2), value: isFocused)
                .onChange(of: isFocused) {
                    appState.isMessageFocused = isFocused
                }
                .onChange(of: appState.isMessageFocused) {
                    isFocused = appState.isMessageFocused
                }
        }
        .background(.thinMaterial)
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .trailing, spacing: 8) {
                    ForEach(0..<100, id: \.self) { index in
                        // TODO: Make custom message
                        Text("Some random text")
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(.blue)
                            .cornerRadius(999)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 60)
                .padding(.bottom, 60)
                .padding()
            }

            VStack {
                Header
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .zIndex(1)

            VStack {
                Spacer()
                Input
            }
            .frame(maxWidth: .infinity)
            .zIndex(1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkSurface)
        .ignoresSafeArea(.container, edges: .top)
    }
}

#Preview {
    ChatView()
        .environmentObject(AppState())
}
