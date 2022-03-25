//
//  MoveModel.swift
//  Tic-Tac-Toe-SwiftUI
//
//  Created by Hermine M on 26/03/2022.
//

import Foundation

enum Player {
    case human
    case computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
