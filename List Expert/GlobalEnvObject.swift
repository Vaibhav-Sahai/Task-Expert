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
            saveTasksArray()
            figureRemaining()
        }
    }
    @Published var individualTasksWork:[individualTask] = []{
        didSet{
            saveTasksArray()
            figureRemaining()
        }
    }
    @Published var individualTasksGroceries:[individualTask] = []{
        didSet{
            saveTasksArray()
            figureRemaining()
        }
    }
    
    @Published var individualTasksMiscellaneous:[individualTask] = []{
        didSet{
            saveTasksArray()
            figureRemaining()
        }
    }
    
    //MARK:- Array Of Task Tittles Passed
    @Published var taskTittlesUrgent: [String] = []{
        didSet{
            saveTaskTitleArray()
        }
    }
    @Published var taskTittlesWork: [String] = []{
        didSet{
            saveTaskTitleArray()
        }
    }
    @Published var taskTittlesGroceries: [String] = []{
        didSet{
            saveTaskTitleArray()
        }
    }
    @Published var taskTittlesMiscellaneous: [String] = []{
        didSet{
            saveTaskTitleArray()
        }
    }
    
    init() {
        //Dev Use ONLY
        //resetDefaults()
        getTasksArray()
        getTaskTitleArray()
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
    func addItemToTaskArray(item: individualTask, taskType: String){
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
    
    func addItemToTaskTitleArray(item: String, taskType: String){
        if taskType.lowercased() == "urgent"{
            self.taskTittlesUrgent.append(item)
        }
        else if taskType.lowercased() == "work"{
            self.taskTittlesWork.append(item)
        }
        else if taskType.lowercased() == "groceries"{
            self.taskTittlesGroceries.append(item)
        }
        else if taskType.lowercased() == "miscellaneous"{
            self.taskTittlesMiscellaneous.append(item)
        }
       
    }
    //MARK:- Save Items
    func saveTasksArray(){
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
    
    func saveTaskTitleArray(){
        UserDefaults.standard.set(taskTittlesUrgent, forKey: Keys.urgentTittles)
        UserDefaults.standard.set(taskTittlesWork, forKey: Keys.workTittles)
        UserDefaults.standard.set(taskTittlesGroceries, forKey: Keys.groceriesTittles)
        UserDefaults.standard.set(taskTittlesMiscellaneous, forKey: Keys.miscellaneousTittles)
    }
    
    //MARK:- Get Items
    func getTasksArray(){
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
    
    func getTaskTitleArray(){
        guard
            let savedUrgentTittles = UserDefaults.standard.stringArray(forKey: Keys.urgentTittles),
            let savedWorkTittles = UserDefaults.standard.stringArray(forKey: Keys.workTittles),
            let savedGroceriesTittles = UserDefaults.standard.stringArray(forKey: Keys.groceriesTittles),
            let savedMiscellaneousTittles = UserDefaults.standard.stringArray(forKey: Keys.miscellaneousTittles)
        else { return }
        
        self.taskTittlesUrgent = savedUrgentTittles
        self.taskTittlesWork = savedWorkTittles
        self.taskTittlesGroceries = savedGroceriesTittles
        self.taskTittlesMiscellaneous = savedMiscellaneousTittles
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
