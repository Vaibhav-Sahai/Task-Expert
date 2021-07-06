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
            //NavigationLink
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Add New Task")
    }
}

struct TaskAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddScreen(taskType: "")
    }
}
