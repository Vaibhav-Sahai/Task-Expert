//
//  TaskAddScreen.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 06/07/2021.
//

import SwiftUI

//MARK:- User Default Keys
struct Keys{
    static let urgentTittles = "urgentTittles"
    static let workTittles = "workTittles"
    static let groceriesTittles = "groceriesTittles"
    static let miscellaneousTittles = "miscellaneousTittles"
}

struct TaskAddScreen: View {
    //MARK:- Passing The Environment
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    
    //MARK:- Data To Be Recieved And Passed
    @Binding var presentViewModal: Bool
    var addTask: (individualTask) -> ()
    //MARK:- Info Taken From Form Here
    @State var tappedTaskBody: Bool = false
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var taskBody: String = ""
    @State var colorScheme: String = "Red"
    @State var color1: String = "TaskRed1"
    @State var color2: String = "TaskRed2"
    
    let taskType: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Add New Task")
                    .font(.system(.largeTitle)).bold()
                    .padding()
                Spacer()
            }
            //MARK:- Info Form
            Form{
                Section(header: Text("New Task Information")) {
                    if tappedTaskBody == false{
                        TextField("Task Body", text: $taskBody)
                        
                    }else{
                        TextField("Task Body", text: $taskBody )
                            .foregroundColor(.black)
                    }
                    Text("Choose Task Color Scheme")
                    Picker("Choose Color", selection: $colorScheme, content: {
                        Text("Red").tag("Red")
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Grey").tag("Grey")
                    }).pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("Add New Task")
            
            //MARK:- Add Task
            VStack(spacing: 10) {
                if showError == true {
                    Text(errorMessage)
                        .font(.body).bold()
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                Button(action: {
                    if checkTaskBody() == true{
                        showError = true
                    }
                    else{
                        if isTaskInVgrid() == true{
                            errorMessage = "Error: Task Has Already Been Entered In \(taskType) Tasks"
                            showError = true
                        }else{
                            viewModelGlobal.addItemToTaskTitleArray(item: taskBody, taskType: taskType)
                            self.presentViewModal = false
                            colorChooser()
                            addTask(.init(title: taskBody, color1: color1, color2: color2))
                        }
                        
                    }
                    
                }, label: {
                    Text("Add Task")
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color("TaskBlue2"))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 4)
                })
                
            //MARK:- Don't Add Task
                Button(action: {
                    self.presentViewModal = false
                    
                }, label: {
                    Text("Cancel")
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color("TaskRed2"))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 4)
                })
            }
            
        }
        .onAppear{
            
        }
    }
    //MARK:- Choose Color
    func colorChooser(){
        if colorScheme == "Red"{
            color1 = "TaskRed1"
            color2 = "TaskRed2"
        }
        if colorScheme == "Blue"{
            color1 = "TaskBlue1"
            color2 = "TaskBlue2"
        }
        if colorScheme == "Green"{
            color1 = "TaskGreen1"
            color2 = "TaskGreen2"
        }
        if colorScheme == "Grey"{
            color1 = "TaskGrey1"
            color2 = "TaskGrey2"
        }
    }
    //MARK:- Checking TaskBody Text
    func isTaskInVgrid() -> Bool{
        if taskType.lowercased() == "urgent" && viewModelGlobal.taskTittlesUrgent.contains(taskBody){
            return true
        }
        else if taskType.lowercased() == "work" && viewModelGlobal.taskTittlesWork.contains(taskBody){
            return true
        }
        else if taskType.lowercased() == "groceries" && viewModelGlobal.taskTittlesGroceries.contains(taskBody){
            return true
        }
        else if taskType.lowercased() == "miscellaneous" && viewModelGlobal.taskTittlesMiscellaneous.contains(taskBody){
            return true
        }
        else{
            return false
        }
    }
    //MARK:- Checking for Errors
    func checkTaskBody() -> Bool{
        if taskBody.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.errorMessage = "Error: Please Fill Task Body"
            return true
        } else{
            return false
        }
    }
    
}

struct TaskAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddScreen(presentViewModal: .constant(false), addTask: {_ in print(123)} , taskBody: "", taskType: "")
            .previewDevice("iPhone 12 Pro Max") //innit preview
    }
}
