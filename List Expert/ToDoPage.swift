//
//  ToDoPage.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

struct ToDoPage: View {
    @State var dateAndTime = "" //Init Identifier
    
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
                HStack(spacing: 70){
                    Text(dateAndTime)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .padding()
                
                    Button(action: {
                        //Toggle Modal Popup View
                        
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
        }.onAppear{
            //Running Date Call
            self.dateFormatterTool()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    //MARK:- Date Management
    func dateFormatterTool(){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, hh:mm a"
        dateAndTime = dateFormatter.string(from: currentDate)
    }
}

struct ToDoPage_Previews: PreviewProvider {
    static var previews: some View {
        ToDoPage()
    }
}
