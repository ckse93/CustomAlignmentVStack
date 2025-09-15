//
//  ContentView.swift
//  CustomAlignmentVStack
//
//  Created by Chan Jung on 9/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("CustomAlignmentHStack")
            CustomAlignmentHStack {
                ZStack {
                    Rectangle().fill(Color.blue).frame(width: 70, height: 90)
                    Text("70x90")
                }
                
                Text("🥕 top")
                    .preferredVAlignment(.top)
                
                Text("🥕 center")
                    .preferredVAlignment(.center)
                
                Text("🥕 bottom")
                    .preferredVAlignment(.bottom)
            }
            .border(Color.cyan, width: 2)
            
            CustomAlignmentVStack {
                Text("CustomAlignmentVStack")
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. I forgot to buy oat milk from my gorcery store today, in my defense, they rearranged the layout for the 4th time this month (lie). I just wanna visit, get what i want, and yeet out but nooooooo i have to go through mountain of sale items for me to grab it the last time smh")
                
                Text("🥕 leeding")
                    .preferredHAlignment(.leading)
                
                Text("center one")
                
                Text("trail")
                    .preferredHAlignment(.trailing)
                
                Image(systemName: "cloud.heavyrain.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .preferredHAlignment(.leading)
                    .offset(x: 12)
            }
            .border(Color.blue, width: 1)
        }
    }
}

#Preview {
    ContentView()
}
