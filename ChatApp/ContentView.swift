//
//  ContentView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            Color.clear
                .background(.thinMaterial)
                .contentShape(Rectangle())
                .onTapGesture {
                    appState.isSearchFocused = false
                    appState.isMessageFocused = false
                }

            HStack(spacing: 0) {
                ListView()
                    .frame(maxWidth: 300)
                    .padding(16)
                    .onTapGesture {
                        appState.isMessageFocused = false
                        appState.isSearchFocused = false
                    }

                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1)
                    .edgesIgnoringSafeArea(.vertical)

                ChatView()
                    .onTapGesture {
                        appState.isSearchFocused = false
                        appState.isMessageFocused = false
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
