//
//  AppState.swift
//  ChatApp
//
//  Created by Michal Ukropec on 16/04/2025.
//

import Foundation

class AppState: ObservableObject {
    @Published var selectedMessageID: Int? = nil
    @Published var searchText: String = ""
    @Published var messageText: String = ""
    
    @Published var isSearchFocused: Bool = false
    @Published var isMessageFocused: Bool = false
}
