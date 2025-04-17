//
//  ChatMessage.swift
//  ChatApp
//
//  Created by Michal Ukropec on 17/04/2025.
//

import SwiftUI

struct ChatMessage: View {
    let messageData: Message

    var body: some View {
        HStack {
            Text(messageData.text)
                .padding(8)
                .background(messageData.isOwn ? .blue : .gray.opacity(0.4))
                .cornerRadius(8)
                .frame(
                    maxWidth: 500,
                    alignment: messageData.isOwn ? .trailing : .leading)
        }
        .frame(
            maxWidth: .infinity,
            alignment: messageData.isOwn ? .trailing : .leading)
    }
}

#Preview {
    ChatMessage(
        messageData: Message(
            text: "AI send it", date: Date(), isOwn: false))
}

#Preview {
    ChatMessage(
        messageData: Message(
            text: "User send it", date: Date(), isOwn: true))
}
