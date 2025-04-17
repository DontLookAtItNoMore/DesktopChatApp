//
//  ThreadCell.swift
//  ChatApp
//
//  Created by Michal Ukropec on 17/04/2025.
//

import SwiftUI

struct ThreadCell: View {
    let sender: String
    let lastMessage: String
    let time: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(sender)
                    .font(.headline)

                Spacer()

                Text(time)
                    .font(.caption)
                    .opacity(isSelected ? 1 : 0.6)
            }

            Text(lastMessage)
                .lineLimit(1)
                .font(.subheadline)
                .opacity(isSelected ? 1 : 0.6)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(alignment: .topLeading)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(
                    isSelected ? .blue : Color.clear)
        )
        .contentShape(Rectangle())
        .animation(.easeInOut(duration: 0.1), value: isSelected)
    }
}

#Preview {
    ThreadCell(
        sender: "Alice",
        lastMessage: "Hey, did you check the design update?",
        time: "14:32",
        isSelected: true
    )
}
