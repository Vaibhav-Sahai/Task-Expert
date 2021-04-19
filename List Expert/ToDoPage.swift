//
//  ToDoPage.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

struct ToDoPage: View {
    var body: some View {
        ZStack{
            //MARK: - Putting Banner on Top
            VStack{
                Image("Banner")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: 500 ,height: 100)
                Spacer()
            }
            //MARK:- Date Time And List Button
            VStack{
                HStack(spacing: 50){
                    Text("31st September, 2021")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .padding()
                    
                    Button(action: {
                        //Add List Stuff Here
                    }) {
                        Image(systemName: "text.insert")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct ToDoPage_Previews: PreviewProvider {
    static var previews: some View {
        ToDoPage()
    }
}
