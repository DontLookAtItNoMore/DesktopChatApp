//
//  SearchBar.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var appState: AppState
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search", text: $appState.searchBarText)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())

            if !appState.searchBarText.isEmpty {
                Button(action: { appState.searchBarText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(
                    appState.searchBarFocus
                        ? Color.accentColor : Color.gray.opacity(0.1),
                    lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(.thinMaterial)
        )
        .animation(.easeInOut(duration: 0.2), value: appState.searchBarFocus)
        .onChange(of: isFocused) {
            appState.searchBarFocus = isFocused
        }
        .onChange(of: appState.searchBarFocus) {
            isFocused = appState.searchBarFocus
        }
        .onAppear() {
            isFocused = false
            appState.searchBarFocus = false
        }
    }
}

#Preview {
    SearchBar()
        .environmentObject(AppState())
}
