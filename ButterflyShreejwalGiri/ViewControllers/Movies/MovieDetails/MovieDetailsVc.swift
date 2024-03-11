//
//  MovieDetailsVc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import Foundation
import UIKit

class MovieDetailsVc: RootVc {
    
    public var navigationDelegate: BaseCoordinator?
    final let provideMovieVm = AppFactory.initialize().provideVmFactory().provideMovieVm()

    var searchText: String = ""
    
    var movieDetails: MovieDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDelegate()
    }
    
    private func setupDelegate() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MovieDetailsCell.self)
        provideMovieVm.delegate = self
        provideMovieVm.getMovieDetails()
    }
}

extension MovieDetailsVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsCell") as? MovieDetailsCell else { return UITableViewCell() }
        if let data = self.movieDetails {
            cell.configure(with: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsVc()
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(vc, animated: true)
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
