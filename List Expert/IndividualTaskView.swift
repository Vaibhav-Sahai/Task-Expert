//
//  UrgentTaskAdd.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 28/06/2021.
//

import SwiftUI

struct individualTask: Hashable {
    var id: Int
    let title: String
    let color1, color2: String
    
}

struct IndividualTaskView: View {
    var columns: [GridItem] =
        Array(repeating: .init(.flexible(maximum: 160), spacing: 30, alignment: .center), count: 2)
    
    //MARK:- Diffferent Arrays
    let individualTasksUrgent:[individualTask] = [
        individualTask(id: 1, title: "Kidnap the kids", color1: "TaskRed1", color2: "TaskRed2")
    ]
    
    let individualTasksWork:[individualTask] = [
        individualTask(id: 1, title: "Kidnap the kids at work", color1: "TaskBlue1", color2: "TaskBlue2")
    ]
    
    let individualTasksGroceries:[individualTask] = [
        individualTask(id: 1, title: "Kidnap the kids at groceries", color1: "TaskGreen1", color2: "TaskGreen2")
    ]
    
    let individualTasksMiscellaneous:[individualTask] = [
        individualTask(id: 1, title: "Kidnap the kids at miscellaneous", color1: "TaskGrey1", color2: "TaskGrey2")
    ]
    //Passed Items
    var taskType: String
    var tasksLeft: String
    
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
                    
                Text("\(tasksLeft) Tasks")
                    .font(.title3)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                
                Spacer()
                
                //MARK:- LazyVGrid Here
                VStack{
                    //Creating the scrollview
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 20){
                            //Checking what task type
                            if taskType.lowercased() == "urgent"{
                                ForEach(individualTasksUrgent, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "work"{
                                ForEach(individualTasksWork, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "groceries"{
                                ForEach(individualTasksGroceries, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                            if taskType.lowercased() == "miscellaneous"{
                                ForEach(individualTasksMiscellaneous, id: \.self){
                                    Task in TaskCellView(task: Task)
                                }
                            }
                        }
                        .padding()
                    }.offset(x: 0, y: 40)
                }
                
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: TaskAddScreen(taskType: taskType),
                        label: {
                            Image(systemName: "text.badge.plus")
                                .resizable()
                                .renderingMode(.original)
                                .foregroundColor(.black)
                                .frame(width: 40, height: 40)
                                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 55))
                    })
                }.padding()

            }
        }
        //Offset Navigation Bar Size
        .offset(x:0 , y: -60)
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
                .lineLimit(6)
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
        .frame(width: 180, height: 240, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(task.color1), Color(task.color2)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(50)
        .shadow(color: .gray, radius: 10)
    }
}

/*
//MARK:- Preview Cell View
struct TaskCellView_Previews: PreviewProvider{
    static var previews: some View{
        individualTaskView(task: individualTask.init(id: 1, title: "Pick up tomatos lettuce cream and soda", color1: "TaskBlue1", color2: "TaskBlue2"))
    }
}
*/

struct IndividualTaskView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualTaskView(taskType: "", tasksLeft: "")
            .previewDevice("iPhone 12 Pro Max")
    }
}
