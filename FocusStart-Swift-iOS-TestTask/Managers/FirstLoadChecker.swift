////
////  FirstLoadChecker.swift
////  FocusStart-Swift-iOS-TestTask
////
////  Created by Дмитрий Скворцов on 13.01.2023.
////
//
//import Foundation
//
//class FirstLoadCheck {
//
//    static let shared = FirstLoadCheck()
//    var firstLoad = true
//
//    init(note: Note? = nil) {
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func firstLoadTableCheck() {
//        if firstLoad {
//            firstLoad = false
//            coreDataSaver = CoreDataSaver()
//            let context = coreDataSaver!.loadPersistentContainer()
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
//
//            do {
//                let results: NSArray = try context.fetch(request) as NSArray
//                for result in results {
//                    let activity = result as! Activity
//                    if activity.isDone != true {
//                        ActivitiesObject.arrayOfActivities.append(activity)
//                    } else {
//                        DoneActivities.doneActivitiesArray.append(activity)
//                    }
//                }
//            } catch {
//                print("Fetch failed")
//            }
//            coreDataSaver = nil
//        }
//    }
//
//    func firstLoadCheckTimeSpent() {
//        if firstLoad {
//            firstLoad = false
//            coreDataSaver = CoreDataSaver()
//            let context = coreDataSaver!.loadPersistentContainer()
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
//
//            do {
//                let results: NSArray = try context.fetch(request) as NSArray
//
//                for result in results {
//                    let activity = result as! Activity
//
//                    if activity.isDone != true {
//                        ActivitiesObject.arrayOfActivities.append(activity)
//                    } else {
//                        DoneActivities.doneActivitiesArray.append(activity)
//                    }
//                }
//            } catch {
//                print("Fetch failed")
//            }
//            coreDataSaver = nil
//        }
//    }
//}
//
