//
//  UrgentTaskAdd.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 28/06/2021.
//

import SwiftUI

struct individualTask: Hashable, Codable {
    let title: String
    let color1, color2: String
    
}

//MARK:- User Default Keys
struct UserDefaultKeys {
    static let SavedIndividualTasksUrgent = "SavedIndividualTasksUrgent"
    static let SavedIndividualTasksWork = "SavedIndividualTasksWork"
    static let SavedIndividualTasksGroceries = "SavedIndividualTasksGroceries"
    static let SavedIndividualTasksMiscellaneous = "SavedIndividualTasksMiscellaneous"
}

struct IndividualTaskView: View {
    //MARK:- Global Environment
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    
    var columns: [GridItem] =
        Array(repeating: .init(.flexible(maximum: 160), spacing: 30, alignment: .center), count: 2)
    
    //MARK:- Passed Items
    var taskType: String
    var tasksLeft: String
    
    //MARK:- Properties to pass and recieve from modal view
    @State private var presentViewModal: Bool = false
    
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
            //MARK:- Task Type and Tasks Remainging
            VStack {
                HStack {
                    Text(taskType)
                        .font(.largeTitle).bold()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                if taskType.lowercased() == "urgent"{
                    Text("\(viewModelGlobal.taskRemainingUrgent) Tasks")
                        .font(.title3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                else if taskType.lowercased() == "work"{
                    Text("\(viewModelGlobal.taskRemainingWork) Tasks")
                        .font(.title3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                else if taskType.lowercased() == "groceries"{
                    Text("\(viewModelGlobal.taskRemainingGroceries) Tasks")
                        .font(.title3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                else if taskType.lowercased() == "miscellaneous"{
                    Text("\(viewModelGlobal.taskRemainingMiscellaneous) Tasks")
                        .font(.title3)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                }
                
                Spacer()
                //MARK:- LazyVGrid Here
                VStack{
                    //Creating the scrollview
                    ScrollView(){
                        LazyVGrid(columns: columns, spacing: 20){
                            //Checking what task type
                            if taskType.lowercased() == "urgent"{
                                ForEach(viewModelGlobal.individualTasksUrgent, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "work"{
                                ForEach(viewModelGlobal.individualTasksWork, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "groceries"{
                                ForEach(viewModelGlobal.individualTasksGroceries, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "miscellaneous"{
                                ForEach(viewModelGlobal.individualTasksMiscellaneous, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                        }
                        .padding()
                        .ignoresSafeArea(.container, edges: .bottom)
                    }
                    .ignoresSafeArea(.container, edges: .bottom)
                    //.offset(x: 0, y: 40)
                    //Offset to Fix VGrid
                    .offset(x: 0, y: 20)
                }
                .offset(x: 0, y: 40)

            }
           
            //MARK:- Present Task Add Screen
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {self.presentViewModal = true}, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.black)
                            //.background(Color(.black))
                            .frame(width: 40, height: 40)
                            .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 60))
                    }).sheet(isPresented: $presentViewModal, content: {
                        TaskAddScreen(presentViewModal: $presentViewModal, addTask: {
                            taskAdded in
                            viewModelGlobal.addItemToTaskArray(item: taskAdded, taskType: taskType)
                            
                        }, taskType: taskType)
                    })
                    
                }.padding()
            }
            .offset(x: 0, y: 60)
            //.offset(x:0, y:60)
            //.offset(x:0,y:20)
        }
        //Offset Navigation Bar Size
        .offset(x:0 , y: -60)
        .onAppear{
            
        }
        .onDisappear{
        }
    }
    
    //MARK:- Clear User Defaults
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

//MARK:- Individual Task Cell View

struct TaskCellView: View {
    let task: individualTask
    var body: some View {
        VStack {
            Spacer()
            
            Text(task.title)
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.25)
                .lineLimit(5)
                .allowsTightening(true)
                .padding()
            HStack {
                Spacer()
                Button{
                    //Action: Task complete
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 0.2897821802, green: 0.7647058964, blue: 0, alpha: 1)))
                        .frame(width: 30, height: 30)
                }
                Spacer()
                Button{
                    //Action: Task discard
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.08644310853, blue: 0.02825784669, alpha: 1)))
                        .frame(width: 30, height: 30)
                }
                Spacer()
            }
            Spacer()
        }
        .frame(width: 180, height: 220, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(task.color1), Color(task.color2)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(50)
        .shadow(color: .gray, radius: 10)
    }
}

/*
//MARK:- Preview Cell View
struct TaskCellView_Previews: PreviewProvider{
    static var previews: some View{
        TaskCellView(task: individualTask.init(title: "Pick up tomatos lettuce cream and soda, test test test test test test test test ", color1: "TaskBlue1", color2: "TaskBlue2"))
            .previewDevice("iPhone 12 Pro Max")
    }
}
*/


struct IndividualTaskView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IndividualTaskView(taskType: "Urgent", tasksLeft: "0").environmentObject(GlobalEnvironment())
                .previewDevice("iPhone 12 Pro Max")
        }
    }
}
