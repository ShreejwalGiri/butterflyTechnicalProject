//
//  MovieListUc.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.

import Foundation
import RxSwift

public class MovieListUc {
    
    private let movieListRepo: MovieListRepo
    
    var page: Int = 1
    
    private var apiCallCount = 0
    
    init(movieListRepo: MovieListRepo) {
        self.movieListRepo = movieListRepo
    }
    
    public func getMovieDetails(id movieID: Int) -> Observable<MovieDetails> {
        self.movieListRepo.getMovieDetails(id: movieID)
    }
    
    func getMovieList(orPage page: Int, paginationEnable: Bool?  = false) -> Observable<MovieList> {
        if paginationEnable ?? false {
            self.page = page
        }
        return self.movieListRepo.getMovieList(orPage: page).map { movieListModel in
            if movieListModel.total_pages ?? 1 > page {
                self.page = 1
            }
            return movieListModel
        }
    }
    
//    func getMovieList(orPage page: Int, paginationEnable: Bool? = false) -> Observable<MovieList> {
//        if !paginationEnable! && apiCallCount >= 5 {
//            return self.movieListRepo.getMovieList(orPage: apiCallCount)
//        }
//
//        if paginationEnable! {
//            self.page = page
//        }
//
//        apiCallCount += 1
//
//        return self.movieListRepo.getMovieList(orPage: page).map { movieListModel in
//            if movieListModel.total_pages ?? 1 > page {
//                self.page = 1
//            }
//            return movieListModel
//        }
//    }
}

