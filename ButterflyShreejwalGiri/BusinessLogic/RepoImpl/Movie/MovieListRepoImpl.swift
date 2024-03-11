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
    
    public func getMovieDetails() -> Observable<MovieDetails> {
        return endpoint.getMovieDetails()
    }
    
    public func getMovieList() -> Observable<MovieList> {
        return endpoint.getMovieList()
    }
}
