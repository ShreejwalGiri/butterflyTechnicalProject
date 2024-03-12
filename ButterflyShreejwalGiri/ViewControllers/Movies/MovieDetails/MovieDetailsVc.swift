//
//  MovieDetailsVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import Foundation
import UIKit

enum MovieDetailsTableType {
    case cover
}

struct MovieDetailsTableData {
    var movieDetailsTableType: MovieDetailsTableType = .cover
}

class MovieDetailsVc: RootVc {
    
    public var navigationDelegate: BaseCoordinator?
    final let provideMovieVm = AppFactory.initialize().provideVmFactory().provideMovieVm()
    
    var searchText: String = ""
    var movieDetailsTableData: [MovieDetailsTableData] = [
        MovieDetailsTableData(movieDetailsTableType: .cover)
    ]
    
    var movieDetails: MovieDetails?
    var selectedMovieList: MovieResult? {
        didSet {
            if let id = selectedMovieList?.id {
                provideMovieVm.delegate = self
                provideMovieVm.getMovieDetails(id: id)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MovieDetailsCell.self)
    }
    
    open override func setupViews() {
        
        self.view.backgroundColor = .systemBackground
        
        let mainStack = UIView().stack(
            tableView,
            spacing: 20
        ).padLeft(0).padRight(0).padTop(0).padBottom(20)
        
        self.view.addSubview(mainStack)
        mainStack.fillSuperview()
        tableViewSetup()
    }
}

extension MovieDetailsVc: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        movieDetailsTableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch movieDetailsTableData[section].movieDetailsTableType {
        case .cover:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch movieDetailsTableData[indexPath.section].movieDetailsTableType {
        case .cover:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell") as? MovieDetailsCell else { return UITableViewCell() }
            cell.configure(with: self.movieDetails)
            return cell
        }
    }
}

extension MovieDetailsVc: MovieListDelegate {
    
    func movieDetails(data: MovieDetails) {
        self.movieDetails = data
        self.tableView.reloadData()
    }
    
    func movieFailure(msg: String) {
    }
}
