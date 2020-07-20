//
//  ContentView.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/12/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Solve.entity(), sortDescriptors: []) var solves: FetchedResults<Solve>

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var timeSpent = 0.0
    @State private var updateTime = false
    @State private var newScramble = false
    @State private var timerColor = Color.black
    @State private var permissionToLaunch = false
    @State private var buttonImage = "start"
    @State var scramble: String


    var body: some View {
        VStack {
            TopMenuView()

            Button(action: {
                self.scramble = self.generateScramble()
            }) {
                Text(scramble)
                    .bold()
                    .font(.system(size: 40))
                    .padding()
            }
            
            Spacer()
            
            Text("\(timeSpent, specifier: "%.2f")")
                .font(.system(size: 60))
                .foregroundColor(timerColor)
            
            Image(buttonImage)
                .renderingMode(.original)
                .cornerRadius(20)
                .onLongPressGesture(minimumDuration: 200, maximumDistance: 1000000, pressing: { isPressed in
                    if self.updateTime == false {
                        if isPressed {
                            self.buttonImage = "startPressed"
                            self.timerColor = Color.yellow
                        } else {
                            self.buttonImage = "start"
                            self.timerColor = Color.black
                        }
                        
                        if self.permissionToLaunch {
                            self.startTimer()
                        }
                    } else {
                        self.stopTimer()
                    }
                }){}
                .simultaneousGesture(LongPressGesture(minimumDuration: 1.0, maximumDistance: 1000000)
                    .onEnded { _ in
                        self.timerColor = Color.green
                        self.permissionToLaunch = true
                        self.newScramble = true
                })

            Spacer()
            Spacer()
        }
        .onReceive(timer) { time in
            if self.updateTime {
                self.timeSpent += 0.01
            }
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

    func startTimer() -> Void {
        self.buttonImage = "stop"
        self.timeSpent = 0.0
        self.updateTime = true
        self.timerColor = Color.black
        self.permissionToLaunch = false
    }

    func stopTimer() -> Void {
        self.updateTime = false
        
        if self.newScramble {
            let solve = Solve(context: self.managedObjectContext)
            solve.moves = self.scramble
            solve.time = self.timeSpent
            solve.timestamp = Date()
            try? self.managedObjectContext.save()
            self.scramble = self.generateScramble()
        }
        
        self.buttonImage = "start"
        self.newScramble = false
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(scramble: "R U R' U'")
    }
}
