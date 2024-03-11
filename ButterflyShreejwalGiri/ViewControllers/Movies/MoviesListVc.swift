//
//  MoviesListVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import Foundation
import UIKit

class MoviesListVc: RootVc {
    
    public var navigationDelegate: BaseCoordinator?
    
    final let provideMovieVm = AppFactory.initialize().provideVmFactory().provideMovieVm()
    
    private var movieList = [MovieResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    private func setupDelegate() {
        
        title = "Butterfly Purchase Orders"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MovieListCell.self)
//        tableView.registerClassHeaderFooter(TitleOnlyHeaderCell.self)
        provideMovieVm.delegate = self
        provideMovieVm.getMovieList()
    }
    
    @objc func addButtonTapped() {
       
        let vc = AddPurchaseVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MoviesListVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListCell else { return UITableViewCell() }
        let items = self.movieList[indexPath.row]
        cell.configure(with: items)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let items = self.movieList[indexPath.row] else { return }
//        let vc = DetailsVc()
//        vc.popupateData(items)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.withHeight(50)
        headerView.backgroundColor = .white
        
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
//           headerView.backgroundColor = .white
           
           let textField = UITextField(frame: CGRect(x: 10, y: 10, width: headerView.frame.width - 20, height: 30))
           textField.placeholder = "Search"
           textField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
           textField.layer.cornerRadius = 5
           textField.layer.masksToBounds = true
           textField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        headerView.addSubview(textField)
        textField.fillSuperview()
           
           return headerView
    }
    
    @objc func searchTextChanged(_ sender: UITextField) {
        // Perform search operation based on the text entered in the search text field
        let searchText = sender.text ?? ""
        print("Search text changed: \(searchText)")
        // Update your data source and reload table view accordingly
    }
}

extension MoviesListVc: MovieListDelegate {
    func movieList(data: [MovieResult]) {
        self.movieList = data
        self.tableView.reloadData()
    }
    
    
    func movieDetails(data: MovieDetails) {
        print(data)
    }
    
    func movieFailure(msg: String) {
    
    }
}

