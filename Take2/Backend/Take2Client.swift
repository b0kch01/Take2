//
//  Take2Client.swift
//  Take2
//
//  Created by Nathan Choi on 3/28/25.
//

import SwiftUI

enum ClientState: Equatable {
    case idle
    case processing
    case completed
}

@Observable class Take2Client {
    var processing: ClientState = .idle

    



}

#Preview {
    ContentView()
}
