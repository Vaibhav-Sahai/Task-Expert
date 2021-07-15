//
//  GlobalEnvObject.swift
//  List Expert
//
//  Created by Vaibhav Sahai on 15/07/2021.
//

import SwiftUI
import Foundation

class GlobalEnvironment: ObservableObject{
    //MARK:- Remaining Labels
    @Published var taskRemainingUrgent = 0
    @Published var taskRemainingWork = 0
    @Published var taskRemainingGroceries = 0
    @Published var taskRemainingMiscellaneous = 0
    @Published var totalRemaining = 0
    
    //MARK:- Individual Arrays
    @Published var individualTasksUrgent:[individualTask] = []{
        didSet{
            saveItems()
            figureRemaining()
        }
    }
    @Published var individualTasksWork:[individualTask] = []{
        didSet{
            saveItems()
            figureRemaining()
        }
    }
    @Published var individualTasksGroceries:[individualTask] = []{
        didSet{
            saveItems()
            figureRemaining()
        }
    }
    
    @Published var individualTasksMiscellaneous:[individualTask] = []{
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
        taskRemainingWork = individualTasksWork.count
        taskRemainingGroceries = individualTasksGroceries.count
        taskRemainingMiscellaneous = individualTasksMiscellaneous.count
        totalRemaining = taskRemainingUrgent + taskRemainingWork + taskRemainingGroceries + taskRemainingMiscellaneous
    }
    
    //MARK:- Append Lists
    func addItem(item: individualTask, taskType: String){
        if taskType.lowercased() == "urgent"{
            self.individualTasksUrgent.append(item)
        }
        else if taskType.lowercased() == "work"{
            self.individualTasksWork.append(item)
        }
        else if taskType.lowercased() == "groceries"{
            self.individualTasksGroceries.append(item)
        }
        else if taskType.lowercased() == "miscellaneous"{
            self.individualTasksMiscellaneous.append(item)
        }
       
    }
    //MARK:- Save Items
    func saveItems(){
        if let encodedDataUrgent = try? JSONEncoder().encode(individualTasksUrgent){
            UserDefaults.standard.set(encodedDataUrgent, forKey: UserDefaultKeys.SavedIndividualTasksUrgent)
        }
        if let encodedDataWork = try? JSONEncoder().encode(individualTasksWork){
            UserDefaults.standard.set(encodedDataWork, forKey: UserDefaultKeys.SavedIndividualTasksWork)
        }
        if let encodedDataGroceries = try? JSONEncoder().encode(individualTasksGroceries){
            UserDefaults.standard.set(encodedDataGroceries, forKey: UserDefaultKeys.SavedIndividualTasksGroceries)
        }
        if let encodedDataMiscellaneous = try? JSONEncoder().encode(individualTasksMiscellaneous){
            UserDefaults.standard.set(encodedDataMiscellaneous, forKey: UserDefaultKeys.SavedIndividualTasksMiscellaneous)
        }
    }
    //MARK:- Get Items
    func getItems(){
        //Decoding
        guard
            let urgentTaskData = UserDefaults.standard.data(forKey: UserDefaultKeys.SavedIndividualTasksUrgent),
            let SavedUrgentTaskData = try? JSONDecoder().decode([individualTask].self, from: urgentTaskData),
            
            let workTaskData = UserDefaults.standard.data(forKey: UserDefaultKeys.SavedIndividualTasksWork),
            let SavedWorkTaskData = try? JSONDecoder().decode([individualTask].self, from: workTaskData),
            
            let groceriesTaskData = UserDefaults.standard.data(forKey: UserDefaultKeys.SavedIndividualTasksGroceries),
            let SavedGroceriesTaskData = try? JSONDecoder().decode([individualTask].self, from: groceriesTaskData),
            
            let miscellaneousTaskData = UserDefaults.standard.data(forKey: UserDefaultKeys.SavedIndividualTasksMiscellaneous),
            let SavedMiscellaneousTaskData = try? JSONDecoder().decode([individualTask].self, from: miscellaneousTaskData)
        else { return }
        
        self.individualTasksUrgent = SavedUrgentTaskData
        self.individualTasksWork = SavedWorkTaskData
        self.individualTasksGroceries = SavedGroceriesTaskData
        self.individualTasksMiscellaneous = SavedMiscellaneousTaskData
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
