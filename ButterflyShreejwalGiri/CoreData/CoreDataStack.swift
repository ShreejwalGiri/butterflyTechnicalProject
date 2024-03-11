////
////  CoreDataStack.swift
////  ButterflyShreejwalGiri
////
////  Created by shreejwal giri on 10/03/2024.
////
//
//import Foundation
//import CoreData
//
//@objc(PurchaseOrder)
//class PurchaseOrder: NSManagedObject {
//    @NSManaged var purchase_id: String?
//    @NSManaged var item: String?
//    @NSManaged var invoice: String?
//    @NSManaged var receipt: String?
//}
//
//class CoreDataStack: ObservableObject {
//    static let shared = CoreDataStack()
//    
//    // Create a persistent container as a lazy variable to defer instantiation until its first use.
//    lazy var persistentContainer: NSPersistentContainer = {
//        
//        // Pass the data model filename to the container’s initializer.
//        let container = NSPersistentContainer(name: "PurchaseOrderList")
//        
//        // Load any persistent stores, which creates a store if none exists.
//        container.loadPersistentStores { _, error in
//            if let error = error {
//                // Handle the error appropriately. However, it's useful to use
//                // `fatalError(_:file:line:)` during development.
//                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
//            }
//        }
//        return container
//    }()
//    
//    func insertPurchaseOrder(purchaseID: String, item: String, invoice: String, receipt: String) {
//         let context = persistentContainer.viewContext
//         let purchaseOrder = PurchaseOrder(context: context)
//         purchaseOrder.purchase_id = purchaseID
//         purchaseOrder.item = item
//         purchaseOrder.invoice = invoice
//         purchaseOrder.receipt = receipt
//         
//         do {
//             try context.save()
//         } catch {
//             let nserror = error as NSError
//             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//         }
//     }
//    
//    func fetchPurchaseOrders() -> [PurchaseOrder] {
//        let context = persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<PurchaseOrder> = PurchaseOrder.fetchRequest()
//        
//        do {
//            let purchaseOrders = try context.fetch(fetchRequest)
//            return purchaseOrders
//        } catch {
//            // Handle fetch errors gracefully, such as logging or returning an empty array.
//            print("Failed to fetch purchase orders: \(error.localizedDescription)")
//            return []
//        }
//    }
//
//
//    
//    private init() { }
//}
//
//
//
