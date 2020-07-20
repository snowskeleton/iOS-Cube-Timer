//
//  ResultsView.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/15/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Solve.entity(), sortDescriptors: []) var solves: FetchedResults<Solve>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(solves, id: \.moves) { solve in
                        SingleScrambleView(time: solve.time, date: "\(solve.timestamp!)", moves: solve.moves!)
                }
                .onDelete { indexSet in
                    let deleteItem = self.solves[indexSet.first!]
                    self.managedObjectContext.delete(deleteItem)
                }
            }
            .navigationBarTitle(Text("Solves"), displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //Test data
                let solve = Solve.init(context: context)
                solve.moves = "R U R' U'"
                solve.time = 69.69
                solve.timestamp = Date()
                return ResultsView().environment(\.managedObjectContext, context)
    }
}
