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

    var columns: [GridItem] =
        Array(repeating: .init(.flexible(maximum: 160), spacing: 30, alignment: .center), count: 2)

    @State var dateAndTime = "" //Init Identifier
    
    //MARK:- Assigning Data to Cells
    let Tasks: [Task] = [
        Task(id: 0, title: "Urgent", image: "exclamationmark", remaining: "0", taskType: "Urgent", colorIcon: Color("LightRed"), colorCell: .red),
        Task(id: 1, title: "Work", image: "bag.fill", remaining: "0", taskType: "Work", colorIcon: Color("LightBlue"), colorCell: .blue),
        Task(id: 2, title: "Groceries", image: "cart", remaining: "0", taskType: "Groceries", colorIcon: Color("LightGreen"), colorCell: .green),
        Task(id: 3, title: "Miscellaneous", image: "pencil", remaining: "0", taskType: "Miscellaneous", colorIcon: Color("LightGray"), colorCell: .gray)
    ]
    
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
            //MARK:- Date Time
            VStack(spacing: 0){
                Spacer()
                Text("Home")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                  
                
                Text(dateAndTime)
                    .font(.title3)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .allowsTightening(true)
                
                Spacer()
                //MARK:- Calling TaskView
                VStack {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 20){
                            ForEach(Tasks, id: \.self){ Task in
                                TaskView(task: Task)
                            }
                        }.padding()
                    }.padding()
                }
            }

        }.onAppear{
            //Running Date Call
            self.dateFormatterTool()
        }
        .navigationTitle("Home")
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
//MARK:- How Each Task Looks
struct TaskView: View {
    let task: Task
    
    var body: some View{
        NavigationLink(
            destination: TaskAdd(),
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
                    
                    VStack(spacing: 10) {
                        Text(task.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.25)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text("Remainging Tasks: " + task.remaining)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 180, height: 180)
                .background(task.colorCell)
                .cornerRadius(50)
                .shadow(color: .gray, radius: 10)
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
            ToDoPage()
                .previewDevice("iPhone 12 Pro Max")
        }
        
    }
}

