//
//  ModelDropdown.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import SwiftUI

struct ModelDropdown: View {
    @State private var selectedModel = "GPT-4"

    let models = ["GPT-4", "Claude 3", "Mistral 7B", "Gemini 1.5"]

    var body: some View {
        Picker("Model", selection: $selectedModel) {
            ForEach(models, id: \.self) { model in
                Text(model)
            }
        }
        .pickerStyle(.menu)
    }
}

#Preview {
    ModelDropdown()
}
