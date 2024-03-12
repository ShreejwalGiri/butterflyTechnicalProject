//
//  MovieListRepoImpl.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import Foundation
import RxSwift

public class MovieListRepoImpl: MovieListRepo {
    
    var endpoint: EndPoint
    
    public init(endpoint: EndPoint) {
        self.endpoint = endpoint
    }
    
    public func getMovieDetails(id movieID: Int) -> Observable<MovieDetails> {
        return endpoint.getMovieDetails(id: movieID)
    }
    
    public func getMovieList(orPage page: Int) -> Observable<MovieList> {
        return endpoint.getMovieList(orPage: page)
    }
}
