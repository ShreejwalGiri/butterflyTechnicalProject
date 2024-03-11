//
//  MovieListCell.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 11/03/2024.
//

import LBTATools

class MovieListCell: UITableViewCell {
    
    lazy private var movieImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy private var movieTitle: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var releaseDate: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        return lbl
    }()
    
    func configure(with item: MovieResult) {
        
        self.contentView.backgroundColor = .systemBackground
        
        self.movieTitle.text = item.title
        self.releaseDate.text = "Release Date : \( item.release_date ?? ""  )"
        self.movieImage.loadImage(fromWebPath: item.poster_full_path ?? "")
        
        let itemInfo = UIView().stack(
            movieTitle,
            releaseDate,
            spacing: 0
        )
        
        movieImage.withHeight(150)
        movieImage.withWidth(120)
        
        hstack(
            movieImage,
            itemInfo,
            spacing: 10.0,
            alignment: .leading
        ).padLeft(10).padRight(10).padTop(10).padBottom(5)
    }
    
}

