//
//  ListView.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 16) {
            SearchBar()

            ScrollView {
                VStack(spacing: 8) {
                    ForEach(0..<100, id: \.self) { index in
                        MessageBubble(
                            isActive: appState.selectedMessageID == index,
                            onTap: {
                                appState.selectedMessageID =
                                    (appState.selectedMessageID == index)
                                    ? nil : index
                            }
                        )
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ListView()
        .frame(maxWidth: 300, maxHeight: 800)
        .padding(8)
        .environmentObject(AppState())
}
