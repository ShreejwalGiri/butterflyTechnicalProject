//
//  MovieResult.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import HandyJSON

public struct MovieResult: HandyJSON {
    public var adult: Bool = false
    public var backdrop_path: String?
    public var genre_ids: [Int]?
    public var id: Int?
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
    public var release_date: String?
    public var title: String?
    public var video: Bool = false
    public var vote_average: Float?
    public var vote_count: Int?
    
    public init() {}
}
