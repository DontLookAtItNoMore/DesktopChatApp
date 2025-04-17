//
//  SideBar.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct SideBar: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 8) {
            SearchBar()

            ScrollView {
                ForEach(appState.filteredThreads) { thread in
                    ThreadCell(
                        sender: thread.name,
                        lastMessage: thread.messages.last?.text ?? "",
                        time: thread.lastMessageDate.formatted(
                            .dateTime.hour().minute()),
                        isSelected: appState.currentThread
                            == thread.id.uuidString
                    )
                    .onTapGesture {
                        appState.currentThread = thread.id.uuidString
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(8)
        .frame(
            minWidth: 320, idealWidth: 320, maxHeight: .infinity,
            alignment: .top
        )
        .contentShape(Rectangle())
        .onTapGesture {
            appState.searchBarFocus = false
        }
    }
}

#Preview {
    SideBar()
        .environmentObject(AppState())
}
