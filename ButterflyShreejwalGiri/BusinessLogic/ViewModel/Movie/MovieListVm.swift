//
//  MovieListVm.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import Foundation
import RxSwift

public protocol MovieListDelegate {
    func movieDetails(data: MovieDetails)
    func movieList(data: [MovieResult])
    func movieFailure(msg: String)
}

public extension MovieListDelegate {
    func movieDetails(data: MovieDetails) {}
    func movieList(data: [MovieResult]) {}
}

public class MovieListVm: BaseVm {
    
    let movieListUc: MovieListUc
    public var delegate: MovieListDelegate?
    
    public init(movieListUc: MovieListUc) {
        self.movieListUc = movieListUc
    }
    
    public func getMovieDetails(id movieId: Int) {
        self.loading.onNext(true)
        disposeBag.insert(
            movieListUc.getMovieDetails(id: movieId).subscribe(onNext: { movieList in
                self.loading.onNext(false)
                if movieList.success == false {
                    self.delegate?.movieDetails(data: movieList)
                } else {
                    self.delegate?.movieFailure(msg: self.errorMsg)
                }
                
            }, onError: { error in
                self.loading.onNext(false)
                self.delegate?.movieFailure(msg: self.errorMsg)
            })
        )
    }
    
    public func getMovieList(forPage page: Int, paginationEnable: Bool? = false) {
        self.loading.onNext(true)
        self.disableloading.onNext(false)
        disposeBag.insert(
            movieListUc.getMovieList(orPage: page, paginationEnable: paginationEnable).subscribe(onNext: { movieList in
                self.loading.onNext(false)
                if movieList.success {
                    self.delegate?.movieList(data: movieList.results ?? [])
                } else {
                    self.delegate?.movieFailure(msg: self.errorMsg)
                }
            }, onError: { error in
                self.loading.onNext(false)
                self.delegate?.movieFailure(msg: self.errorMsg)
            })
        )
    }
    
    
}
