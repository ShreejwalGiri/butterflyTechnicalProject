//
//  HomeVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import UIKit

class HomeVc: RootVc {
    
    final let purchaseListVm = AppFactory.initialize().provideVmFactory().providePurchaseListVm()
    
    private var purchaseList = [PurchaseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(PurchaseCell.self)
        tableView.registerClassHeaderFooter(TitleOnlyHeaderCell.self)
        purchaseListVm.delegate = self
        purchaseListVm.getPurchaseList()
    }
}

extension HomeVc: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.purchaseList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.purchaseList[section].items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseCell") as? PurchaseCell else { return UITableViewCell() }
        let items = self.purchaseList[indexPath.section].items?[indexPath.row]
        cell.configure(with: items ?? Items())
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleOnlyHeaderCell.identifier) as! TitleOnlyHeaderCell
        let title = self.purchaseList[section].customer
        cell.titleLabel.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension HomeVc: PurchaseDelegate {
    func getPurchaseList(data: [PurchaseModel]) {
        self.purchaseList = data
        self.tableView.reloadData()
    }
    
    func purchaseFailure(msg: String) {
        print(msg)
    }
}