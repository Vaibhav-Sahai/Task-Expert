//
//  TaskAddScreen.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 06/07/2021.
//

import SwiftUI

struct TaskAddScreen: View {
    //MARK:- Info Taken From Form Here
    @State var taskBody: String = ""
    @State var colorScheme: String = "Red"
    let taskType: String
    var body: some View {
        VStack {
            //Info Form
            Form{
                Section(header: Text("New Task Information")) {
                    TextField("Task Body", text: $taskBody )
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
                NavigationLink(
                    destination: individualTaskView(task: individualTask.init(id: 2, title: "", color1: "", color2: "")),
                    label: {
                        Text("Add Task")
                            .frame(width: 280, height: 50)
                            .foregroundColor(.white)
                            .background(Color("TaskBlue2"))
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 4)
                })
            //MARK:- Don't Add Task
                NavigationLink(
                    destination: individualTaskView(task: individualTask.init(id: 2, title: "", color1: "", color2: "")),
                    label: {
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
}

struct TaskAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddScreen(taskType: "")
    }
}
