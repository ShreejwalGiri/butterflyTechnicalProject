//
//  MovieResponse.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import HandyJSON

public struct MovieList: HandyJSON {
    public var page: Int?
    public var results: [MovieResult]?
    public var total_pages: Int?
    public var total_results: Int?
    
    public init() {}
}
