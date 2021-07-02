//
//  UrgentTaskAdd.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 28/06/2021.
//

import SwiftUI

struct TaskAdd: View {
    var taskType: String
    
    var body: some View {
        //MARK:- Header 
        ZStack {
            VStack{
                Image("Banner")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: 500 ,height: 100)
                Spacer()
            }
            VStack {
                Text(taskType)
                    .font(.largeTitle).bold()
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                Spacer()
            }
        }
        //Offset Navigation Bar Size
        .offset(x:0 , y: -60)
    }
}

struct TaskAdd_Previews: PreviewProvider {
    static var previews: some View {
        TaskAdd(taskType: "")
    }
}
