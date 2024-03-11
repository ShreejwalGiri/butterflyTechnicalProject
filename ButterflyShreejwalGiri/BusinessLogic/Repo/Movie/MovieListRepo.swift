//
//  MovieListRepo.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import Foundation
import RxSwift

public protocol MovieListRepo {
    func getMovieDetails() -> Observable<MovieDetails>
    func getMovieList() -> Observable<MovieList>
}
