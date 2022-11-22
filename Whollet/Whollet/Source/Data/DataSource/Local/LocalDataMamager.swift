import UIKit
import CoreData

final class LocalDataManager: NSObject {
    static let shared = LocalDataManager()
    private let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Whollet")
        container.loadPersistentStores { (_, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container.viewContext
    }()
    
    func deleteSearch(_ search: SearchCoinModel) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchHistory")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try context.fetch(fetchRequest)
            for item in items where item.value(forKey: "id") as? String == (search.id ?? "") {
                context.delete(item)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveSearch(_ search: SearchCoinModel) {
        let entity = NSEntityDescription.entity(forEntityName: "SearchHistory", in: context)!
        let detail = NSManagedObject(entity: entity, insertInto: context)
        detail.setValue(search.id, forKey: "id")
        detail.setValue(search.symbol, forKey: "symbol")
        detail.setValue(search.apiSymbol, forKey: "api_symbol")
        detail.setValue(search.name, forKey: "name")
        detail.setValue(search.large, forKey: "large")
        detail.setValue(search.marketCapRank, forKey: "market_cap_rank")
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getSearchHistory(completion: @escaping ([SearchCoinModel], Error?) -> (Void)) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SearchHistory")
        fetchRequest.includesPropertyValues = false
        do {
            let items = try context.fetch(fetchRequest)
            let list = items.enumerated().map { index, item -> SearchCoinModel in
                return SearchCoinModel(item: item)
            }
            completion(list, nil)
        } catch let error as NSError {
            DispatchQueue.main.async {
                completion([], error)
            }
            return
        }
    }
}
