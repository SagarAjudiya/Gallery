//
//  CoreData.swift
//  Gallery
//
//  Created by Sagar Ajudiya on 12/05/24.
//

import CoreData

class CoreDataWrapper {

    static let shared = CoreDataWrapper()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourDataModelName")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private init() {}

    // Create a generic entity to store response data
    func createTableForResponseModel<T: Codable>(_ responseModel: T.Type, jsonData: Data) {
        let context = persistentContainer.viewContext

        guard let entityDescription = NSEntityDescription.entity(forEntityName: "GenericResponseEntity", in: context) else {
            print("Entity description not found")
            return
        }

        let newRecord = NSManagedObject(entity: entityDescription, insertInto: context)
        newRecord.setValue(jsonData, forKey: "jsonData")

        do {
            try context.save()
            print("Table created successfully for response model.")
        } catch let error as NSError {
            print("Could not save record. \(error), \(error.userInfo)")
        }
    }

    // Retrieve data from Core Data
    func fetchResponseModels<T: Decodable>(responseModelType: T.Type, completion: @escaping ([T]?, Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "GenericResponseEntity")

        do {
            let fetchedRecords = try context.fetch(fetchRequest)
            print("Fetched records:", fetchedRecords)
            let responseModels = fetchedRecords.compactMap { record -> T? in
                guard let jsonData = record.value(forKey: "jsonData") as? Data else {
                    print("Error: jsonData is nil")
                    return nil
                }
                // Decode JSON data into the provided response model type
                let decoder = JSONDecoder()
                do {
                    let responseModel = try decoder.decode(T.self, from: jsonData)
                    return responseModel
                } catch {
                    print("Error decoding response data:", error)
                    return nil
                }
            }
            completion(responseModels, nil)
        } catch {
            print("Error fetching records:", error)
            completion(nil, error)
        }
    }

}
