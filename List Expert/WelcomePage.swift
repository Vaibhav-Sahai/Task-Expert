//
//  ContentView.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 18/04/2021.
//

import SwiftUI

//MARK:- Intro Text
struct ContentView: View {
    @State private var alertIsPresented = true
    @State var username = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 10){ //Holds All Text
                    Spacer()
                    //Managing Hello Text
                    if username != ""{
                        Text("Hello, "+username+"!")
                            .font(.system(size: 64, weight: .bold, design: .default))
                            .minimumScaleFactor(0.25)
                            .lineLimit(1)
                            .multilineTextAlignment(.center)
                            .allowsTightening(true)
                            .padding()
                    }else{
                        Text("Hello!")
                            .font(.system(size: 64, weight: .bold, design: .default))
                            .minimumScaleFactor(0.25)
                            .lineLimit(1)
                            .allowsTightening(true)
                            .padding()
                    }
                    
                    WelcomeTextView(tasks: 10) //Does the Welcome Text
                    Spacer()
                    //Buttons:
                    VStack(spacing: 10){
                        NavigationLink(
                            destination: ToDoPage(),
                            label: {
                                Text("Continue")
                                    .frame(width: 280, height: 50)
                                    .foregroundColor(.white)
                                    .background(Color("Magenta"))
                                    .cornerRadius(10)
                                    .shadow(color: Color("Magenta"), radius: 4)
                            })
                        Button{
                            alertView()
                        } label: {
                            Text("Introduce Yourself")
                                .frame(width: 280, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(color: .blue, radius: 4)
                                .padding(.bottom, 80)
                        }
                    }
                }

            }
            .navigationBarHidden(true)
        }
    }
    //Mark:- Alert View
    func alertView(){
        let alert = UIAlertController(title: "Hello, New User!", message: "Enter Your Name", preferredStyle: .alert)
        alert.addTextField { (pass) in
            pass.placeholder = "Name"
            
        }
        let confirmName = UIAlertAction(title: "Confirm", style: .default) { (_) in
            username = alert.textFields![0].text!
            username = username.trimmingCharacters(in: .whitespaces)
        }
        alert.addAction(confirmName)
        //Presenting the Alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
    }
}

//MARK:- Where to Make Calls From
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK:- Pass Parameter To Number of Task Here
struct WelcomeTextView: View{
    var tasks: Int
    var body: some View{
        HStack(spacing: 5){
            Text("You've \(tasks) Tasks Pending!")
                .font(.system(size: 24, weight: .regular, design: .default))
                .padding()
        }
    }
}
