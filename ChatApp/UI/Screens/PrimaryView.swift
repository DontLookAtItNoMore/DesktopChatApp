//
//  PrimaryView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 17/04/2025.
//

import SwiftUI

struct PrimaryView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            ScrollViewReader { scrollProxy in
                ScrollView {
                    VStack {
                        ForEach(appState.currentMessages.indices, id: \.self) {
                            index in
                            let message = appState.currentMessages[index]

                            ChatMessage(messageData: message)
                                .id(index)
                        }

                        Color.clear
                            .id("bottom-anchor")
                            .frame(height: 72)
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
                .onChange(of: appState.currentMessages.count) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                        scrollProxy.scrollTo("bottom-anchor", anchor: .bottom)
                    }
                }
            }

            VStack {
                Spacer()
                MessageBar()
                    .padding(16)
                    .background(.thinMaterial)
            }
        }
        .background(Color.customDarkGray)
    }
}

extension Color {
    static let customDarkGray = Color(
        red: 30 / 255, green: 30 / 255, blue: 30 / 255)
}

#Preview {
    PrimaryView()
        .environmentObject(AppState())
}
