//
//  TopMenuView.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/15/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//

import SwiftUI

struct TopMenuView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Solve.entity(), sortDescriptors: []) var solves: FetchedResults<Solve>
    
    @State var showResults = false
    var body: some View {
        HStack {
            
            
            Button(action: {
                self.showResults.toggle()
            }) {
                Text("Resutls")
            }.padding(.leading)
                .sheet(isPresented: $showResults) {
                    ResultsView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            Spacer()
            
            Spacer()
            
            Button(action: {
                //
            }) {
                Text("Options")
            }.padding(.trailing)
            
        }
        
    }
}

struct TopMenuView_Previews: PreviewProvider {
    static var previews: some View {
        TopMenuView()
    }
}
