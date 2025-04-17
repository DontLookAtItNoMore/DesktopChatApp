//
//  ContentView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Color.clear
                .background(.thinMaterial)

            NavigationSplitView {
                SideBar()
                    .frame(minWidth: 320, maxHeight: .infinity)
                    .background(.thinMaterial)
            } detail: {
                PrimaryView()
            }
            .onTapGesture {
                appState.searchBarFocus = false
                appState.messageBarFocus = false
            }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button {
                        appState.searchBarText = ""

                        let newThread = Thread(
                            name: "New Chat",
                            messages: [],
                            lastMessageDate: Date(),
                            createdAt: Date()
                        )

                        withAnimation {
                            appState.threads.insert(newThread, at: 0)
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.005)
                        {
                            appState.currentThread = newThread.id.uuidString
                        }

                        appState.currentThread = newThread.id.uuidString

                    } label: {
                        Label("New Chat", systemImage: "plus")
                    }

                }

                ToolbarItem(placement: .navigation) {
                    Button {
                        withAnimation {
                            appState.deleteCurrentThread()
                            appState.currentThread =
                                appState.threads.first?.id.uuidString ?? ""
                        }
                    } label: {
                        Label("New Chat", systemImage: "delete.left")
                    }
                }

                ToolbarItem(placement: .navigation) {
                    Menu {
                        Button(
                            "gpt-3.5-turbo",
                            action: { appState.currentAIModel = "gpt-3.5-turbo" })
                        Button(
                            "gpt-4.1",
                            action: { appState.currentAIModel = "gpt-4.1" })
                        Button(
                            "gpt-4o",
                            action: { appState.currentAIModel = "gpt-4o" })
                        Button(
                            "gpt-4o-search-preview",
                            action: {
                                appState.currentAIModel =
                                    "gpt-4o-search-preview"
                            }
                        )
                    } label: {
                        Text(appState.currentAIModel)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
