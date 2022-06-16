//
//  TitleCollectionViewCell.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 10/06/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(posterImageView)
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with posterPath: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
