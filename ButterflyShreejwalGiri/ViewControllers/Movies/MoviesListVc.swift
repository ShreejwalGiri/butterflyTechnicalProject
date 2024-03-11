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
    private var filteredMovieList = [MovieResult]()
    var searchText: String = ""
    
    private var currentPage = 1
    private let itemsPerPage = 20
    private var isLoadingMore = false
    
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
        provideMovieVm.delegate = self
        provideMovieVm.getMovieList(forPage: 1)
    }
    
    @objc func addButtonTapped() {
        
        let vc = AddPurchaseVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterData() {
        if searchText.isEmpty {
            filteredMovieList = movieList
        } else {
            filteredMovieList = movieList.filter { movie in
                if let title = movie.title {
                    return title.localizedCaseInsensitiveContains(searchText)
                }
                return false
            }
        }
    }
}

extension MoviesListVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as? MovieListCell else { return UITableViewCell() }
        let items = self.filteredMovieList[indexPath.row]
        cell.configure(with: items)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsVc()
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .white
        
        let textField = UITextField(frame: CGRect(x: 10, y: 10, width: headerView.frame.width - 20, height: 50))
        textField.placeholder = "Search For Movies"
        textField.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        headerView.addSubview(textField)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filteredMovieList.count - 1 && !isLoadingMore {
            currentPage += 1
            isLoadingMore = true
            provideMovieVm.getMovieList(forPage: currentPage) // Load next page
        }
    }
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        filterData()
        tableView.reloadData()
    }
}

extension MoviesListVc: MovieListDelegate {
    
    func movieList(data: [MovieResult]) {
        self.isLoadingMore = false
        self.movieList.append(contentsOf: data)
        filterData()
        tableView.reloadData()
    }
    
    
    func movieDetails(data: MovieDetails) {
        print(data)
    }
    
    func movieFailure(msg: String) {
        
    }
}

