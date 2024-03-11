//
//  MovieListUc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.

import Foundation
import RxSwift

public class MovieListUc {
    
    private let movieListRepo: MovieListRepo
    
    init(movieListRepo: MovieListRepo) {
        self.movieListRepo = movieListRepo
    }
    
    public func getMovieDetails() -> Observable<MovieDetails> {
        self.movieListRepo.getMovieDetails()
    }
    
    func getMovieList() -> Observable<MovieList> {
        self.movieListRepo.getMovieList()
    }
}

