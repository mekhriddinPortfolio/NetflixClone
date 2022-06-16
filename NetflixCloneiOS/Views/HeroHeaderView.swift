//
//  HeroHeaderView.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 08/06/22.
//

import UIKit

class HeroHeaderView: UIView {
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "joker")
        return imageView
    }()
    
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    
    private func applyConstraints() {
        
    
        let playButttonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            playButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let downloadButttonConstraints = [
            downloadButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 20),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        
        NSLayoutConstraint.activate(playButttonConstraints)
        NSLayoutConstraint.activate(downloadButttonConstraints)
    }
    
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterUrl)") else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
    }
}
