//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

@main
struct ChatAppApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .frame(
                    minWidth: 660, maxWidth: 1200,
                    minHeight: 290, maxHeight: 600
                )
                .background(WindowConfigurator())
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
}

struct WindowConfigurator: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSView()

        DispatchQueue.main.async {
            if let window = view.window {
                window.titlebarAppearsTransparent = true
                window.titleVisibility = .hidden
                window.isOpaque = false
                window.backgroundColor = .clear
            }
        }

        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
