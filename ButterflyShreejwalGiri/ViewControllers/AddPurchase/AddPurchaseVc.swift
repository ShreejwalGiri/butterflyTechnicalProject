//
//  AddPurchaseVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 10/03/2024.
//

import Foundation
import LBTATools
import CoreData

class AddPurchaseVc: RootVc {
    
    var itemsList = [Items]()
    
    final let purchaseListVm = AppFactory.initialize().provideVmFactory().providePurchaseListVm()
    
    private lazy var customerNameTextField: UITextField = {
        let textField = UITextField()
        textField.withHeight(30)
        textField.placeholder = "Enter Customer Name"
        return textField
    }()
    
    lazy private var addItemBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add Item", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        return btn
    }()
    
    
    lazy private var savePurchase: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Purchase", for: .normal)
        btn.backgroundColor = .systemIndigo
        return btn
    }()
    
    var context: NSManagedObjectContext?{
        return (UIApplication.shared.delegate as? AppDelegate)?
            .persistentContainer.viewContext
    }
    
    func fetchData() -> [NSFetchRequestResult]? {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PurchaseOrder")
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "PurchaseOrder", in: managedContext) else {
            print("Failed to retrieve entity description")
            return
        }
        
        let purchaseOrder = NSManagedObject(entity: entity, insertInto: managedContext)
        
        purchaseOrder.setValue("1", forKeyPath: "invoice")
        purchaseOrder.setValue("test", forKeyPath: "item")
        purchaseOrder.setValue("test", forKeyPath: "purchase_order")
        purchaseOrder.setValue("test", forKeyPath: "receipt")
        
        do {
            try managedContext.save()
            print("Data saved successfully")
        } catch let error as NSError {
            print("Could not save data. \(error), \(error.userInfo)")
        }
    }
    
    @objc func addItem(_ sender: UIButton) {
        let vc = AddItemVc()
        vc.navigationController?.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.purchaseListVm.delegate = self
        self.purchaseListVm.fetchItem()
    }
    
    open override func setupViews() {
        
        self.view.backgroundColor = .systemBackground
        self.tableView.registerClass(PurchaseCell.self)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let mainStack = UIView().stack(
            customerNameTextField,
            addItemBtn,
            tableView,
            savePurchase,
            spacing: 20
        ).padLeft(16).padRight(16).padTop(16).padBottom(20)
        
        self.view.addSubview(mainStack)
        mainStack.fillSuperview()
    }
}

extension AddPurchaseVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell") as? PurchaseCell else { return UITableViewCell() }
        let items = itemsList[indexPath.row]
        cell.configure(with: items)
        return cell
    }
}

extension AddPurchaseVc: PurchaseDelegate {
    
    func purchaseFailure(msg: String) {
    }
    
    func fetchSavedItem(data: [Items]) {
        if !data.isEmpty {
            self.itemsList = data
            self.tableView.reloadData()
        }
    }
}
