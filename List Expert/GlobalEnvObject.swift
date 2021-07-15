//
//  GlobalEnvObject.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 15/07/2021.
//

import SwiftUI
import Foundation

class GlobalEnvironment: ObservableObject{
    @Published var taskRemainingUrgent = 0
    @Published var individualTasksUrgent:[individualTask] = []{
        didSet{
            saveItems()
            figureRemaining()
        }
    }
    init() {
        //Dev Use ONLY
        //resetDefaults()
        getItems()
        figureRemaining()
    }
    //MARK:- Take Care of Labelling
    func figureRemaining(){
        taskRemainingUrgent = individualTasksUrgent.count
    }
    
    //MARK:- Append Lists
    func addItem(item: individualTask){
        self.individualTasksUrgent.append(item)
    }
    //MARK:- Save Items
    func saveItems(){
        if let encodedDataUrgent = try? JSONEncoder().encode(individualTasksUrgent){
            UserDefaults.standard.set(encodedDataUrgent, forKey: UserDefaultKeys.SavedIndividualTasksUrgent)
        }
    }
    //MARK:- Get Items
    func getItems(){
        //Decoding
        guard
            let urgentTaskData = UserDefaults.standard.data(forKey: UserDefaultKeys.SavedIndividualTasksUrgent),
            let SavedUrgentTaskData = try? JSONDecoder().decode([individualTask].self, from: urgentTaskData)
        else { return }
        self.individualTasksUrgent = SavedUrgentTaskData
    }
    //MARK:- Reset UserDefaults
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

}
