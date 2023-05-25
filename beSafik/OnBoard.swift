//
//  File.swift
//  beSafik
//
//  Created by Safik Widiantoro on 25/05/23.
//

import SwiftUI


struct OnBoard : View {
    var body: some View {
        NavigationStack{
            TabView{
                VStack{
                   Image("this_me")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    Text("Would you like to get to know me?")
                }
                VStack{
                    Image("this_me_2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                    
                    Text("This body part represents me.")
                    NavigationLink(destination: ContentView()) {
                        Text("Know me more")
                    }
                }
            }.tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        
        
    }
    
}
