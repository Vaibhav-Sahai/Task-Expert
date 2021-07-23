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
    
    //MARK:- Present Lottie Animation
    @State var presentCongratsView = false
    @State var presentForgoneView = false
    
    @State var animatePlaceholder = false
    var body: some View {
        //MARK:- Header 
        ZStack {
            VStack{
                Image("Banner")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: abs(.infinity) ,height: 100)
                Spacer()
            }
           
            //MARK:- Task Type and Tasks Remainging
            VStack {
                HeaderView(taskType: taskType)
                Spacer()
                //MARK:- LazyVGrid Here
                VStack{
                    //Creating the scrollview
                    ScrollView(){
                        if presentCongratsView{
                            LottieAnimationTypeCongrats(filename: "TaskCompletedGIF")
                        }
                        if presentForgoneView{
                            LottieAnimationTypeForgone()
                        }
                        if placeHolderText(taskType: taskType){
                            Text("Your Tasks Will Appear Here")
                                .font(.title).bold()
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                                .minimumScaleFactor(0.25)
                                .lineLimit(1)
                                .allowsTightening(true)
                                .animation(Animation.spring().delay(0))
                        }
                        LazyVGrid(columns: columns, spacing: 20){
                            //Checking what task type
                            if taskType.lowercased() == "urgent"{
                                ForEach(viewModelGlobal.individualTasksUrgent, id: \.self){
                                    Task in TaskCellView(presentCongratsView: $presentCongratsView, presentForgoneView: $presentForgoneView, animatePlaceholder: $animatePlaceholder, task: Task, taskType: taskType)
                                }
                            }
                            if taskType.lowercased() == "work"{
                                ForEach(viewModelGlobal.individualTasksWork, id: \.self){
                                    Task in TaskCellView(presentCongratsView: $presentCongratsView, presentForgoneView: $presentForgoneView, animatePlaceholder: $animatePlaceholder, task: Task, taskType: taskType)
                                }
                            }
                            if taskType.lowercased() == "groceries"{
                                ForEach(viewModelGlobal.individualTasksGroceries, id: \.self){
                                    Task in TaskCellView(presentCongratsView: $presentCongratsView, presentForgoneView: $presentForgoneView, animatePlaceholder: $animatePlaceholder, task: Task, taskType: taskType)
                                }
                            }
                            if taskType.lowercased() == "miscellaneous"{
                                ForEach(viewModelGlobal.individualTasksMiscellaneous, id: \.self){
                                    Task in TaskCellView(presentCongratsView: $presentCongratsView, presentForgoneView: $presentForgoneView, animatePlaceholder: $animatePlaceholder, task: Task, taskType: taskType)
                                }
                            }
                        }
                        .padding()
                        .ignoresSafeArea(.container, edges: .bottom)
                        .animation(Animation.spring())
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
    }
    //MARK:- Figure Out PlaceHolder Text
    func placeHolderText(taskType: String) -> Bool{
        if taskType.lowercased() == "urgent" && viewModelGlobal.individualTasksUrgent.count == 0{
            
            return true
        }
        else if taskType.lowercased() == "work" && viewModelGlobal.individualTasksWork.count == 0{
            
            return true
        }
        else if taskType.lowercased() == "groceries" && viewModelGlobal.individualTasksGroceries.count == 0{
            
            return true
        }
        else if taskType.lowercased() == "miscellaneous" && viewModelGlobal.individualTasksMiscellaneous.count == 0{
           
            return true
        }
        return false
    }
    //MARK:- Clear User Defaults
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

//MARK:- Header View
    
struct HeaderView: View {
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    
    let taskType: String
    var body: some View{
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
    }
}
//MARK:- Individual Task Cell View

struct TaskCellView: View {
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    @State var showAlertYes: Bool = false
    @State var showAlertNo: Bool = false
    
    //MARK:- Show Lottie Animation
    @Binding var presentCongratsView: Bool
    @Binding var presentForgoneView: Bool
    
    @Binding var animatePlaceholder: Bool
    
    let task: individualTask
    let taskType: String
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
                    self.showAlertYes = true

                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 0.2897821802, green: 0.7647058964, blue: 0, alpha: 1)))
                        .frame(width: 30, height: 30)
                }
                //MARK:- Confirm Yes View
                .alert(isPresented: $showAlertYes, content: {
                    Alert(title: Text("Have You Completed This Task?"), message: Text("'\(task.title)' Is The Highlighted Task"),primaryButton: .default(Text("Yes"), action: {
                        viewModelGlobal.removeItemFromTaskArray(item: task, taskType: taskType)
                        viewModelGlobal.removeItemFromTaskTitleArray(item: task.title, taskType: taskType)
                        presentCongratsView = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.presentCongratsView = false
                        }
                    }), secondaryButton: .cancel(Text("No")))
                })
                Spacer()
                Button{
                    //Action: Task discard
                    self.showAlertNo = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.08644310853, blue: 0.02825784669, alpha: 1)))
                        .frame(width: 30, height: 30)
                }
                //MARK:- Confirm No View
                .alert(isPresented: $showAlertNo, content: {
                    Alert(title: Text("Would You Like To Forgo This Task?"), message: Text("'\(task.title)' Is The Highlighted Task"), primaryButton: .default(Text("Yes"), action: {
                        viewModelGlobal.removeItemFromTaskArray(item: task, taskType: taskType)
                        viewModelGlobal.removeItemFromTaskTitleArray(item: task.title, taskType: taskType)
                        presentForgoneView = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.presentForgoneView = false
                        }
                    }), secondaryButton: .cancel(Text("No")))
                })
                Spacer()
            }
            Spacer()
        }
        .frame(width: 180, height: 220, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(task.color1), Color(task.color2)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(50)
        .shadow(color: .black, radius: 2.5)
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
}
