//
//  MovieListRepo.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import Foundation
import RxSwift

public protocol MovieListRepo {
    func getMovieDetails(id movieID: Int) -> Observable<MovieDetails>
    func getMovieList(orPage page: Int) -> Observable<MovieList>
}
