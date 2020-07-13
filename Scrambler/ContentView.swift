//
//  ContentView.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/12/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var scramble: String
    var body: some View {
        VStack {
            Button(action: {
                self.scramble = self.generateScramble()
            }) {
                Text(scramble)
                    .bold()
                    .font(.system(size: 40))
            }
            .padding()
            Spacer()
        }
    }
    
    
    func generateScramble() -> String {
        let moves = ["R", "L", "F", "B", "U", "D"]
        let opposites = ["L", "R", "B", "F", "D", "U"]
        let modifiers = ["'", "2", ""]
        var scramble: [String] = []
        var ultimate: String = ""
        var penultimate: String = ""
        var current: String = ""
        
        while scramble.count < 20 {
            //used to keep the loop going if I break it. apparently a simple "redo" is too much to ask for.
            while scramble.count < 20 {
                current = moves.randomElement()!
                
                if current == ultimate {
                    break
                } else if current == penultimate && ultimate == opposites[moves.firstIndex(of: current) ?? 0] {
                    break
                } else {
                    penultimate = ultimate
                    ultimate = current
                    scramble.append(current + modifiers.randomElement()!)
                }
            }
            
        }
        let result = scramble.joined(separator: " ")
        return result
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(scramble: "R U R' U'")
    }
}
