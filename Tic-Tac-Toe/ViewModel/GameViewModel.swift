//
//  GameViewModel.swift
//  Tic-Tac-Toe-SwiftUI
//
//  Created by Hermine M on 26/03/2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @AppStorage("winCount") var winCount = 0
    @AppStorage("drawCount") var drawCount = 0
    @AppStorage("lossCount") var lossCount = 0
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    
    private func generateMove(playerChoice: String?, player: Player, boardIndex: Int) -> Move {
        var indicator: String {
            if player == .human {
                if playerChoice == "xmark" {
                    return "xmark"
                } else {
                    return "circle"
                }
            } else {
                if playerChoice == "xmark" {
                    return "circle"
                } else {
                    return "xmark"
                }
            }
        }
        
        return Move(player: player, boardIndex: boardIndex, indicator: indicator)
    }
    
    func processPlayerMove(for position: Int, playerChoice: String?) {
        // Human move processing
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = self.generateMove(playerChoice: playerChoice, player: .human, boardIndex: position)
        
        if checkWinCondition(for: .human, in: moves) {
            winCount += 1
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            drawCount += 1
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        // Computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = self.generateMove(playerChoice: playerChoice, player: .computer, boardIndex: computerPosition)
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                lossCount += 1
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(in: moves) {
                drawCount += 1
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains { $0?.boardIndex == index }
    }
    
    // If AI can win, then win
    // If AI can't win, then block
    // If AI can't block, then take middle square
    // If AI can't take middle square, take random available square
    func determineComputerMovePosition(in move: [Move?]) -> Int {
        // If AI can win, then win
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        let computerMoves = moves.compactMap { $0 }.filter{ $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter{ $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        
        // If AI can't block, then take middle square
        let centerSqaure = 4
        if !isSquareOccupied(in: moves, forIndex: centerSqaure) {
            return centerSqaure
        }
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6]
        ]
        
        let playerMoves = moves.compactMap { $0 }.filter{ $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
