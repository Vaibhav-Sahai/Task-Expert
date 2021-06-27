//
//  AddTask.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 27/06/2021.
//

import SwiftUI

struct AddTask: View {
    @State var newListName = ""
    
    var body: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 30){
                
                Text("Name Your New List")
                    .font(.system(size: 32, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .allowsTightening(true)
                
                //MARK:- Textfield Here
                TextField("Enter List Name", text: $newListName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 380, height: 50)
                
      
                //MARK:- Add Cancel Buttons
                VStack(spacing: 10){
                    NavigationLink(
                        destination: ToDoPage(),
                        label: {
                            Text("Add")
                                .frame(width: 280, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        })
                    
                    NavigationLink(
                        destination: ToDoPage(),
                        label: {
                            Text("Cancel")
                                .frame(width: 280, height: 50)
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)
                        })
                    
                }
                
            }.padding()
        }

    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        AddTask()
            
    }
}
