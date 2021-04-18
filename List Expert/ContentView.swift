//
//  ContentView.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

//MARK:- Intro Text
struct ContentView: View {
    var body: some View {
        ZStack{
            VStack(alignment: .center ,spacing: 75){ //Holds All Text + Button
                Text("Hello!")
                    .font(.system(size: 64, weight: .bold, design: .default))
                    .allowsTightening(true)
                
                WelcomeTextView(tasks: 10) //Does the Welcome Text
                
                Button{
                    print("Clicked")
                } label: {
                    Text("Continue")
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
        }
    }
}

//MARK:- Where to Make Calls From
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK:- Pass Parameter To Number of Task Here
struct WelcomeTextView: View{
    var tasks: Int
    var body: some View{
        HStack(spacing: 5){
            Text("You've")
                .font(.system(size: 24, weight: .regular, design: .default))
            Text("\(tasks)")
                .font(.system(size: 24, weight: .regular, design: .default))
            Text("Tasks Pending!")
                .font(.system(size: 24, weight: .regular, design: .default))
        }
    }
}
