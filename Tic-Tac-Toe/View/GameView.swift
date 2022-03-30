//
//  GameView.swift
//  Tic-Tac-Toe-SwiftUI
//
//  Created by Hermine M on 24/03/2022.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    var playerChoice: String?
    var body: some View {
        ZStack(alignment: .topTrailing) {
            PointsView()
            
            GeometryReader { geometry in
                LinearGradient(gradient: Gradient(colors: [Color(.systemTeal).opacity(0.7), Color(.systemPurple).opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns, spacing: 5, content: {
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geometry)
                            
                                PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i, playerChoice: playerChoice)
                            }
                        }
                    })
                    Spacer()
                }
                .disabled(viewModel.isGameboardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem, content: { alertItem in
                    Alert(
                        title: alertItem.title,
                        message: alertItem.message,
                        dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }
                        )
                    )
                })
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}

