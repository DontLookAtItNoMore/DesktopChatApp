//
//  AppMainView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 17/04/2025.
//

import SwiftUI

struct AppMainView: View {
    @EnvironmentObject var appState: AppState
    @Binding var showDrawer: Bool

    var body: some View {
        GeometryReader { geo in
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
            .sheet(isPresented: $showDrawer) {
                DrawerView()
                    .frame(
                        width: geo.size.width - CGFloat(52),
                        height: geo.size.height - CGFloat(26)
                    )
                    .transition(.move(edge: .bottom))
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .zIndex(1)
            }
            .toolbar {
                toolbarButtons
            }
        }
    }

    @ToolbarContentBuilder
    var toolbarButtons: some ToolbarContent {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                    appState.currentThread = newThread.id.uuidString
                }
            } label: {
                Label("New Chat", systemImage: "plus")
            }
        }

        ToolbarItem(placement: .navigation) {
            Button {
                withAnimation {
                    showDrawer = true
                }
            } label: {
                Label("Open Drawer", systemImage: "chevron.up.square")
            }
        }

        if !appState.threads.isEmpty {
            ToolbarItem(placement: .navigation) {
                Button {
                    withAnimation {
                        appState.deleteCurrentThread()
                        appState.currentThread =
                            appState.threads.first?.id.uuidString ?? ""
                    }
                } label: {
                    Label("Delete Chat", systemImage: "delete.left")
                }
            }
        }

        ToolbarItem(placement: .navigation) {
            Menu {
                Button("gpt-3.5-turbo") {
                    appState.currentAIModel = "gpt-3.5-turbo"
                }
                Button("gpt-4.1") {
                    appState.currentAIModel = "gpt-4.1"
                }
                Button("gpt-4o") {
                    appState.currentAIModel = "gpt-4o"
                }
                Button("gpt-4.1-mini") {
                    appState.currentAIModel = "gpt-4.1-mini"
                }
            } label: {
                Text(appState.currentAIModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
