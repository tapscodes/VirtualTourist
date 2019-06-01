//
//  CoreData.swift
//  VirtualTourist
//
//  Created by Tristan Pudell-Spatscheck on 5/27/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import CoreData

var pins : [Pin] = []
var currentPinIndex: Int = -1


var dataController = DataController(modelName: "VirtualTourist")
class DataController {
    let persistentContainer:NSPersistentContainer
    var isLoaded: Bool = false
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName:String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        
    }
    func configureContexts() {
        viewContext.automaticallyMergesChangesFromParent = true
    }
    func load(completion: (() -> Void)? = nil) {
        if (isLoaded == false) { // make sure we only load the store wants
            persistentContainer.loadPersistentStores { storeDescription, error in
                guard error == nil else {
                    fatalError(error!.localizedDescription)
                }
                self.configureContexts()
                completion?()
            }
            isLoaded = true
        }
    }
}
