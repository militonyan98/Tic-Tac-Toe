//
//  PointsView.swift
//  Tic-Tac-Toe
//
//  Created by Hermine M on 26/03/2022.
//

import SwiftUI

struct PointsView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Victories:")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text("\(viewModel.winCount)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            Spacer()
            HStack {
                Text("Draws:")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text("\(viewModel.drawCount)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
            Spacer()
            HStack {
                Text("Losses:")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text("\(viewModel.lossCount)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
            }
        }
        .padding()
        .frame(width:180, height: 90)
        .foregroundColor(Color(.systemBlue).opacity(0.9))

    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
            .preferredColorScheme(.dark)
    }
}
