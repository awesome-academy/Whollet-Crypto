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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.search)
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
        let entity = NSEntityDescription.entity(forEntityName: Entities.search, in: context)!
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.search)
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
    
    func saveTransactionHistory(_ transaction: TransactionDetail) {
        let entity = NSEntityDescription.entity(forEntityName: Entities.transaction, in: context)!
        let detail = NSManagedObject(entity: entity, insertInto: context)
        detail.setValue(transaction.from, forKey: "from")
        detail.setValue(transaction.to, forKey: "to")
        detail.setValue(transaction.totalAmount, forKey: "total_amount")
        detail.setValue(transaction.status, forKey: "status")
        detail.setValue(transaction.totalAmountUSD, forKey: "total_amount_usd")
        detail.setValue(transaction.time, forKey: "time")
        detail.setValue(transaction.id, forKey: "id")
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getAllTransactionHistory(completion: @escaping ([TransactionDetail]?, Error?) -> (Void)) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.transaction)
        fetchRequest.includesPropertyValues = false
        do {
            let items = try context.fetch(fetchRequest)
            let list = items.enumerated().map { index, item -> TransactionDetail in
                return TransactionDetail(item: item)
            }
            completion(list, nil)
        } catch let error as NSError {
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
    }
}
