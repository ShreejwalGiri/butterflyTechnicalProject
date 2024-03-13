//
//  MovieCoordinator.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 13/03/2024.
//

import UIKit

public protocol MovieCoordinatorDelegate: Coordinator{
    func openMovieDetailView(selectedData: MovieResult)
}

open class MovieCoordinator: BaseCoordinator, MovieCoordinatorDelegate {
    
    public override func rootView() -> UIViewController {
        let movieListVc = MoviesListVc()
        movieListVc.navigationDelegate = self
        self.navigationController = UINavigationController(rootViewController: movieListVc)

        return self.navigationController
    }
    
    public func openMovieDetailView(selectedData: MovieResult) {
        let vc = MovieDetailsVc()
        vc.navigationDelegate = self
        vc.selectedMovieList = selectedData
        vc.modalPresentationStyle = .formSheet
        self.navigationController.present(vc, animated: true)
    }
    
}
