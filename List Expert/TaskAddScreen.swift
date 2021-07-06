//
//  TaskAddScreen.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 06/07/2021.
//

import SwiftUI

struct TaskAddScreen: View {
    let taskType: String
    var body: some View {
        Text("\(taskType)")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct TaskAddScreen_Previews: PreviewProvider {
    static var previews: some View {
        TaskAddScreen(taskType: "")
    }
}
