//
//  MovieList.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import HandyJSON

public struct MovieDetails: HandyJSON {
    public var success: Bool = false
    public var adult: Bool = false
    public var backdrop_path: String?
    public var belongs_to_collection: Any?
    public var budget: Int?
    public var genres: [Genre]?
    public var homepage: String?
    public var id: Int?
    public var imdb_id: String?
    public var original_language: String?
    public var original_title: String?
    public var overview: String?
    public var popularity: Float?
    public var poster_path: String?
    public var poster_full_path: String? {
        get {
            return SchemeEnvironmentConfig.baseImageUrl + (self.poster_path ?? "")
        }
    }
    public var production_companies: [ProductionCompany]?
    public var production_countries: [ProductionCountry]?
    public var release_date: String?
    public var revenue: Int?
    public var runtime: Int?
    public var spoken_languages: [SpokenLanguage]?
    public var status: String?
    public var tagline: String?
    public var title: String?
    public var video: Bool = false
    public var vote_average: Float?
    public var vote_count: Int?
    
    public init() {}
}
