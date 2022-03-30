//
//  Alerts.swift
//  Tic-Tac-Toe-SwiftUI
//
//  Created by Hermine M on 26/03/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(
        title: Text("You Win!"),
        message: Text("Congratulations!!!"),
        buttonTitle: Text("Play Again")
    )
    
    static let computerWin = AlertItem(
        title: Text("You Lost"),
        message: Text("Better luck next time."),
        buttonTitle: Text("Rematch")
    )
    
    static let draw = AlertItem(
        title: Text("Draw"),
        message: Text("What a battle of wits we have here..."),
        buttonTitle: Text("Try Again")
    )
}
