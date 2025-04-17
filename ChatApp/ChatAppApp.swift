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
                #if os(macOS)
                    .background(WindowConfigurator())
                #endif
        }
        .windowResizability(.contentSize)
        #if os(macOS)
            .windowToolbarStyle(.unified)
            .windowStyle(.hiddenTitleBar)
        #endif
    }
}

#if os(macOS)
    struct WindowConfigurator: NSViewRepresentable {
        func makeNSView(context: Context) -> NSView {
            let view = NSView()

            DispatchQueue.main.async {
                if let window = view.window {
                    window.titlebarAppearsTransparent = false
                    window.isOpaque = false
                    window.backgroundColor = .clear
                }
            }

            return view
        }

        func updateNSView(_ nsView: NSView, context: Context) {}
    }
#endif
