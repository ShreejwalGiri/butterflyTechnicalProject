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
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    private func setupDelegate() {
        
        title = "Movie List"
        searchBar.placeholder = "Search Movies"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        searchBar.delegate = self 
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MovieListCell.self)
        provideMovieVm.delegate = self
        provideMovieVm.getMovieList(forPage: 1, paginationEnable: true)
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
        vc.selectedMovieList = self.filteredMovieList[indexPath.row]
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let mainView = UIView()
        mainView.withHeight(100)
        mainView.withWidth(self.view.frame.width - 20)
        
        mainView.addSubview(searchBar)
        searchBar.fillSuperview(padding: UIEdgeInsets(top: 12, left: 8, bottom: 12, right: 8))
        
        return mainView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == filteredMovieList.count - 1 && !isLoadingMore {
            currentPage += 1
            isLoadingMore = true
            provideMovieVm.getMovieList(forPage: currentPage)
        }
    }
    

    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        filterData()
        tableView.reloadData()
    }
}

extension MoviesListVc: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text ?? ""
        filterData()
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchBar.text ?? ""
        filterData()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        currentPage = 1
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
        AlertHandler.showFailureAlert(vc: self, message: msg)
    }
}

