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
        img.contentMode = .redraw
        return img
    }()
    
    lazy private var movieTitle: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemBold_14()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var releaseDate: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var overview: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .justified
        lbl.numberOfLines = 5
        return lbl
    }()
    
    lazy private var viewMore: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemSmallItalic_10()
        lbl.text = "Load More..."
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.movieImage.roundCorners(corners: .allCorners, radius: 20)
    }
    
    func configure(with item: MovieResult) {
        
        self.contentView.backgroundColor = .systemBackground
        
        self.movieTitle.text = item.title
        self.releaseDate.text = "Release Date : \( item.release_date ?? ""  )"
        self.movieImage.loadImage(fromWebPath: item.poster_full_path ?? "")
        self.overview.text = item.overview
        
        let itemInfo = UIView().stack(
            movieTitle,
            releaseDate,
            UIView().stack(
            overview,
            viewMore,
            spacing: 2
            ).padTop(4),
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

