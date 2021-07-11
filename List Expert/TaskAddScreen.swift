//
//  TaskAddScreen.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 06/07/2021.
//

import SwiftUI

struct TaskAddScreen: View {
    //MARK:- Data To Be Recieved And Passed
    @Binding var presentViewModal: Bool
    var addTask: (individualTask) -> ()
    //MARK:- Info Taken From Form Here
    @State var tappedTaskBody:Bool = false
    @State var showError:Bool = false
    @State var taskBody: String = "Task Body"
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
                        TextField("Task Body", text: $taskBody )
                        .foregroundColor(.gray)
                            .onTapGesture {
                                self.taskBody = ""
                                self.tappedTaskBody = true
                            }

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
                    Text("Error: Please Fill Task Body")
                        .font(.body).bold()
                        .foregroundColor(.red)
                }
                Button(action: {
                    if checkTaskBody() == "Empty String"{
                        showError = true
                    }
                    else{
                        showError = false
                        self.presentViewModal = false
                        colorChooser()
                        addTask(.init(title: taskBody, color1: color1, color2: color2))
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
    func checkTaskBody() -> String{
        if taskBody.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Empty String"
        }
        else if taskBody == "Task Body"{
            return "Empty String"
        }
        else{
            return "No Problemo"
        }
    }
}

struct TaskAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddScreen(presentViewModal: .constant(false), addTask: {_ in print(123)} , taskBody: "", taskType: "" )
            .previewDevice("iPhone 12 Pro Max") //innit preview
    }
}
