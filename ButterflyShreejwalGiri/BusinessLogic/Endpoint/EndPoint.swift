//
//  EndPoint.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 09/03/2024.
//

import Foundation
import RxSwift

public protocol EndPoint {
    func getPurchaseList() -> Observable<[PurchaseModel]>
    func getMovieDetails(id movieID: Int) -> Observable<MovieDetails>
    func getMovieList(orPage page: Int) -> Observable<MovieList>
}
