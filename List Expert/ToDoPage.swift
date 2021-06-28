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
    let title, image, remaining: String
    let colorIcon, colorCell: Color
    
}

struct ToDoPage: View {

    var columns: [GridItem] =
        Array(repeating: .init(.flexible(maximum: 160), spacing: 35, alignment: .center), count: 2)

    @State var dateAndTime = "" //Init Identifier
    
    //MARK:- Assigning Data to Cells
    let Tasks: [Task] = [
        Task(id: 0, title: "Urgent Tasks", image: "exclamationmark", remaining: "0", colorIcon: Color("LightRed"), colorCell: .red),
        Task(id: 1, title: "Work Tasks", image: "bag.fill", remaining: "0", colorIcon: Color("LightBlue"), colorCell: .blue),
        Task(id: 2, title: "Shopping Tasks", image: "cart", remaining: "0", colorIcon: Color("LightGreen"), colorCell: .green),
        Task(id: 3, title: "Miscellaneous Tasks", image: "pencil", remaining: "0", colorIcon: Color("LightGray"), colorCell: .gray)
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
            VStack(spacing: 10){
                HStack(spacing: 70){
                    Text(dateAndTime)
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .minimumScaleFactor(0.25)
                        .lineLimit(1)
                        .allowsTightening(true)
                        .padding()
                }
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
            destination: UrgentTaskAdd(),
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
                            .font(.system(size: 15, weight: .semibold, design: .default))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.25)
                            .lineLimit(1)
                            .allowsTightening(true)
                        
                        Text("Remainging Tasks: " + task.remaining)
                            .font(.system(size: 11, weight: .light, design: .default))
                            .foregroundColor(.black)
                    }
                }
                .frame(width: 180, height: 180)
                .background(task.colorCell)
                .cornerRadius(50)
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
        ToDoPage()
            .previewDevice("iPhone 12 Pro Max")
        
    }
}

