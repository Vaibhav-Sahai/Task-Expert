//
//  ToDoPage.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

struct ToDoPage: View {
    @State var dateAndTime = "" //Init Identifier
    @State var isPresentingAddModal = false
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
                        self.isPresentingAddModal.toggle()
                    }) {
                        Image(systemName: "text.insert")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                    }
                }
                //Show Modal Popup View
                .fullScreenCover(isPresented: $isPresentingAddModal, content: {
                    AddModal(isPresented: self.$isPresentingAddModal)
                })
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
//MARK:- Modal Popup View
struct AddModal: View{
    //Var Declarations
    @Binding var isPresented: Bool
    @State var listName = ""
    
    var body: some View{
        ZStack{
            VStack(spacing: 40){

                Text("Create New List")
                    .font(.system(size: 42, weight: .semibold, design: .default))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .padding()
                
                TextField("Enter List Name", text: $listName)
                    .frame(width: 280, height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                //Add And Cancel Buttons
                VStack(spacing: 10){
                    Button(action: {
                        
                    }, label: {
                        Text("Add")
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: Color.blue, radius: 4)
                    })
                    Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                            .shadow(color: Color.red, radius: 4)
                })
                }
            }.padding()
        }
    }
}

struct ToDoPage_Previews: PreviewProvider {
    static var previews: some View {
        ToDoPage()
    }
}
