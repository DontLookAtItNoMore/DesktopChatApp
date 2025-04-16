//
//  MessageBubble.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct MessageBubble: View {
    let isActive: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("John Doe")
                    .font(.headline)
                Spacer()
                Text("14:30")
                    .opacity(isActive ? 1 : 0.65)
                    .animation(.easeInOut(duration: 0.25), value: isActive)
            }

            Text(
                "Informacia o spotrebe: vycerpali ste 100% dat z Vasho pausalu."
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(isActive ? 1 : 0.65)
            .animation(.easeInOut(duration: 0.1), value: isActive)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .background(isActive ? Color.blue : Color.clear)
        .cornerRadius(6)
        .contentShape(Rectangle())
        .animation(.easeInOut(duration: 0.1), value: isActive)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                onTap()
            }
        }
    }
}

#Preview {
    MessageBubble(
        isActive: true,
        onTap: {}
    )
}
