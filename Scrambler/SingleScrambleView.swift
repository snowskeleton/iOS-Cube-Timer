//
//  SingleScrambleView.swift
//  Scrambler
//
//  Created by Isaac Lyons on 7/16/20.
//  Copyright © 2020 Blizzard Skeleton. All rights reserved.
//

import SwiftUI

struct SingleScrambleView: View {
    var time: Double
    var timeStamp: String
    var moves: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(time, specifier: "%.2f")")
                Text("\(moves)")
                    .font(.system(size: 12))
            }
            
            Text("\(timeStamp)")
                .font(.system(size: 8))
        }
    }
}

struct SingleScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        SingleScrambleView(time: 4.20, timeStamp: "2020-07-17 02:51:43", moves: "R U R' U'")
    }
}
