//
//  WelcomeView.swift
//  Tic-Tac-Toe
//
//  Created by Hermine M on 26/03/2022.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    
    private var backgroundGrad = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(.systemTeal).opacity(0.7),
                Color(.systemPurple).opacity(0.7)
            ]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    private var grad = LinearGradient(
        gradient: Gradient(
            colors: [
                Color(.systemBlue).opacity(0.7),
                Color(.systemPurple).opacity(0.7)
            ]
        ),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGrad
                VStack {
                    Text("Welcome to XO")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.systemPurple).opacity(0.7))
                        .overlay(self.grad)
                        .mask(
                            Text("Welcome to XO")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.systemPurple).opacity(0.7))
                        )
                    Spacer()
                    VStack {
                        Text("Choose")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color(.systemPurple).opacity(0.7))
                            .overlay(self.grad)
                            .mask(
                                Text("Choose")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(.systemPurple).opacity(0.7))
                            )
                        HStack {
                            ZStack {
                                Circle()
                                    .foregroundColor(.purple).opacity(0.25)
                                    .frame(width: 80, height: 80)
                                NavigationLink(destination: GameView(playerChoice: "xmark")) {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color(.systemBlue))
                                }
                                .navigationBarHidden(true)
                                .navigationTitle("Main")
                                .edgesIgnoringSafeArea([.top, .bottom])
                            }
                            .onTapGesture {
                                viewModel.choice = "xmark"
                            }
                            
                            ZStack {
                                Circle()
                                    .foregroundColor(.purple).opacity(0.25)
                                    .frame(width: 80, height: 80)
                                NavigationLink(destination: GameView(playerChoice: "circle")) {
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color(.systemTeal))
                                }
                                .navigationBarHidden(true)
                                .navigationTitle("Main")
                                .edgesIgnoringSafeArea([.top, .bottom])
                            }
                            .onTapGesture {
                                viewModel.choice = "circle"
                            }
                        }
                    }
                    Spacer()
                }
                .frame(width: 300, height: 600)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
