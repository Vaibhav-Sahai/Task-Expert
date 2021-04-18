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
        ZStack{
            VStack(alignment: .center ,spacing: 75){ //Holds All Text + Button
                //Managing Hello Text
                if username != ""{
                    Text("Hello, "+username+"!")
                        .font(.system(size: 64, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.5)
                        .padding()
                }else{
                    Text("Hello!")
                        .font(.system(size: 64, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .allowsTightening(true)
                        .minimumScaleFactor(0.25)
                        .padding()
                }
                
                WelcomeTextView(tasks: 10) //Does the Welcome Text
                
                Button{
                    alertView()
                    print("Clicked")
                } label: {
                    Text("Continue")
                        .frame(width: 280, height: 50)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
            }
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
            Text("You've")
                .font(.system(size: 24, weight: .regular, design: .default))
            Text("\(tasks)")
                .font(.system(size: 24, weight: .regular, design: .default))
            Text("Tasks Pending!")
                .font(.system(size: 24, weight: .regular, design: .default))
        }
    }
}
