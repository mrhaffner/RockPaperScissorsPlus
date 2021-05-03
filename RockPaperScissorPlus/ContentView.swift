//
//  ContentView.swift
//  RockPaperScissorPlus
//
//  Created by Matt Haffner on 5/2/21.
//

import SwiftUI

struct ContentView: View {
    @State private var turnNumber = 1
    @State private var points = 0
    @State private var CPUSelection = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var gameOver = false
    
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your score is \(points)")
            Text("Computer chooses \(moves[CPUSelection])")
            Text("Make the \(shouldWin ? "winning" : "losing") move")
            HStack {
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.selectMove(number)
                    }) {
                        Text(moves[number])
                    }
                }
            }
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Game Over"), message: Text("Your score is \(self.points)"), dismissButton: .default(Text("New Game")) {
                self.newGame()
                
            })
        }

    }
    
    func newGame() {
        turnNumber = 1
        points = 0
    }
    
    func selectMove(_ playerSelection: Int) {
        turnNumber += 1
        if shouldWin {
            if playerSelection - 1 == CPUSelection || playerSelection + 2 == CPUSelection {
                print(playerSelection, CPUSelection)
                points += 1
            } else {
                points -= 1
            }
        } else {
            if playerSelection + 1 == CPUSelection || playerSelection - 2 == CPUSelection {
                points += 1
            } else {
                points -= 1
            }
        }
        CPUSelection = Int.random(in: 0...2)
        shouldWin = Bool.random()
        if turnNumber > 10 {
            gameOver = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
