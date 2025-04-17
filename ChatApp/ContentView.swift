//
//  ContentView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct DrawerView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("This is the drawer")
                .font(.title)
            Text("It can contain anything")
            Spacer()
        }
        .padding()
    }
}

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var showDrawer = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.clear.background(.thinMaterial)

                AppMainView(showDrawer: $showDrawer)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
