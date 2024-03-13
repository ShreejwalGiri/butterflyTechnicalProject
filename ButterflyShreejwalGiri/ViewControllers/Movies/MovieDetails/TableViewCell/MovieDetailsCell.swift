//
//  MovieDetailsCell.swift
//  ButterflyShreejwalGiri
//
//  Created by shreejwal giri on 12/03/2024.
//

import LBTATools

class MovieDetailsCell: UITableViewCell {
    
    lazy private var movieImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .redraw
        return img
    }()

 
    lazy private var titleLable: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemBold_14()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var titleValue: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .right
        return lbl
    }()
    
    lazy private var releaseDateLabel: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemBold_14()
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy private var releaseDateValue: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .right
        return lbl
    }()
    
    lazy private var overview: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy private var spokenLanguageLabel: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemBold_14()
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy private var spokenLanguageValue: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy private var popularityLabel: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemBold_14()
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy private var popularityValue: UILabel = {
        let lbl = Themes.labelThemes.baseTheme.systemRegular_12()
        lbl.textAlignment = .right
        lbl.numberOfLines = 1
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.movieImage.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
    }
    
    func configure(with item: MovieDetails?) {
        
        self.contentView.backgroundColor = .systemBackground
        
        self.titleLable.text =  "Movie Title"
        self.titleValue.text = item?.title
        self.releaseDateLabel.text =  "Release Date"
        self.releaseDateValue.text =  item?.release_date
        self.movieImage.loadImage(fromWebPath: item?.poster_full_path ?? "NA")
        self.overview.text = item?.overview
        
        self.spokenLanguageLabel.text = "Spoken Language"
        let spokenLanguageString = (item?.spoken_languages?.map { $0.english_name ?? "N/A" } ?? []).joined(separator: ", ")
        self.spokenLanguageValue.text = spokenLanguageString
        
        self.popularityLabel.text = "Popularity"
        self.popularityValue.text = "\(item?.popularity ?? 0)"
        
        let mainView = UIView().stack(
            movieImage.withHeight(350),
            UIView().stack(
                overview,
                UIView().stack(
                    UIView().hstack(
                        titleLable,
                        titleValue,
                        spacing: 8
                    ).padLeft(20).padRight(20).padTop(12),
                    UIView().hstack(
                        spokenLanguageLabel,
                        spokenLanguageValue,
                        spacing: 8
                    ).padLeft(20).padRight(20).padTop(12),
                    UIView().hstack(
                        popularityLabel,
                        popularityValue,
                        spacing: 8
                    ).padLeft(20).padRight(20).padTop(12),
                    UIView().hstack(
                        releaseDateLabel,
                        releaseDateValue,
                        spacing: 8
                    ).padLeft(20).padRight(20).padTop(12),
                    spacing: 8
                ),
                spacing: 12
            ).padLeft(12).padRight(12).padTop(12)
        )
        
        self.contentView.addSubview(mainView)
        mainView.fillSuperview()
    }
    
}
