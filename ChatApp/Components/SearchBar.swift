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

            TextField("Search", text: $appState.searchText)
                .focused($isFocused)
                .textFieldStyle(PlainTextFieldStyle())
                .onSubmit { /* TODO: */  }

            if !appState.searchText.isEmpty {
                Button(action: { appState.searchText = "" }) {
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
                    appState.isSearchFocused
                        ? Color.accentColor : Color.gray.opacity(0.1),
                    lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(.thinMaterial)
        )
        .animation(.easeInOut(duration: 0.2), value: appState.isSearchFocused)
        .onChange(of: isFocused) {
            appState.isSearchFocused = isFocused
        }
        .onChange(of: appState.isSearchFocused) {
            isFocused = appState.isSearchFocused
        }

        .onAppear {
            isFocused = appState.isSearchFocused
        }
        .onTapGesture {
            isFocused = true
            appState.isSearchFocused = true
        }
    }
}

#Preview {
    ListView()
        .frame(maxWidth: 300, maxHeight: 800)
        .padding(8)
        .environmentObject(AppState())
}
