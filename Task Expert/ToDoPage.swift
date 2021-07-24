//
//  ToDoPage.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

//MARK:- Cells For Task Managers
struct Task: Hashable{
    var id: Int
    let title, image, remaining, taskType: String
    let colorIcon, colorCell: Color
    
}

struct ToDoPage: View {
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    var columns: [GridItem] =
        Array(repeating: .init(.flexible(maximum: 100), spacing: 85, alignment: .center), count: 2)

    @State var dateAndTime = "" //Init Identifier

    //MARK:- Assigning Data to Cells

    @State var Tasks: [Task]
    
    init() {
        Tasks = [
            Task(id: 0, title: "Urgent", image: "exclamationmark", remaining: "0", taskType: "Urgent", colorIcon: Color("LightRed"), colorCell: .red),
            Task(id: 1, title: "Work", image: "bag.fill", remaining: "0", taskType: "Work", colorIcon: Color("LightBlue"), colorCell: .blue),
            Task(id: 2, title: "Groceries", image: "cart", remaining: "0", taskType: "Groceries", colorIcon: Color("LightGreen"), colorCell: .green),
            Task(id: 3, title: "Miscellaneous", image: "pencil", remaining: "0", taskType: "Miscellaneous", colorIcon: Color("LightGray"), colorCell: .gray)
        ]
    }
 
    var body: some View {
        
        ZStack{
            //MARK: - Putting Banner on Top
            VStack{
                Image("Banner")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: abs(.infinity) ,height: 100)
                Spacer()
            }
            //MARK:- Date Time
            VStack(spacing: 0){
                Spacer()
                Text("Home")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .animation(Animation.easeIn.delay(0.1))
                
                Text(dateAndTime)
                    .font(.title3)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .animation(Animation.easeIn.delay(0.2))
                
                Spacer()
                //MARK:- Calling TaskView
                VStack {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(Tasks, id: \.id){ Task in
                                TaskView( task: Task)
                            }
                            .animation(Animation.easeIn.delay(0.3))
                        }
                    }
                    .padding(.top,30)
                }
            }

        }
        .onAppear{
            //Running Date Call
            self.dateFormatterTool()
            Tasks = [
                Task(id: 0, title: "Urgent", image: "exclamationmark", remaining: "\(viewModelGlobal.taskRemainingUrgent)", taskType: "Urgent", colorIcon: Color("LightRed"), colorCell: .red),
                Task(id: 1, title: "Work", image: "bag.fill", remaining: "\(viewModelGlobal.taskRemainingWork)", taskType: "Work", colorIcon: Color("LightBlue"), colorCell: .blue),
                Task(id: 2, title: "Groceries", image: "cart", remaining: "\(viewModelGlobal.taskRemainingGroceries)", taskType: "Groceries", colorIcon: Color("LightGreen"), colorCell: .green),
                Task(id: 3, title: "Miscellaneous", image: "pencil", remaining: "\(viewModelGlobal.taskRemainingMiscellaneous)", taskType: "Miscellaneous", colorIcon: Color("LightGray"), colorCell: .gray)
            ]
            //print("On Home Screen")
            //print(env.taskRemainingUrgent)
        }
        .navigationTitle("Home")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .environmentObject(viewModelGlobal)
    }
    //MARK:- Date Management
    func dateFormatterTool(){
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, hh:mm a"
        dateAndTime = dateFormatter.string(from: currentDate)
    }

}
//MARK:- How Each Task Looks
struct TaskView: View {
    @EnvironmentObject var viewModelGlobal: GlobalEnvironment
    let task: Task
    
    var body: some View{
        NavigationLink(
            destination: IndividualTaskView(taskType: task.taskType, tasksLeft: task.remaining).environmentObject(viewModelGlobal),
            label: {
                VStack{
                    Image(systemName: task.image)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(task.colorIcon)
                        .cornerRadius(100)
                    
                    VStack(spacing: 5) {
                        Text(task.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.25)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text("Remaining Tasks: " + task.remaining)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 170, height: 180)
                .background(task.colorCell)
                .cornerRadius(50)
                .shadow(color: .black, radius: 2.5)
            })
        
    }
}
/*
//MARK:- Uncomment To Change Task Cell View
struct TaskView_Previews: PreviewProvider{
    static var previews: some View{
        TaskView()
    }
}
*/

struct ToDoPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoPage().environmentObject(GlobalEnvironment())
                .previewDevice("iPhone 12 mini")
        }
        
    }
}

