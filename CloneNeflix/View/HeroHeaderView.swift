//
//  HeroHeaderView.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class HeroHeaderView: UIView {
    
    private let playButton : UIButton  = {
       let button = UIButton()
        button.setTitle("Play" , for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadButton : UIButton  = {
       let button = UIButton()
        button.setTitle("Download" , for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private var heroImageView : UIImageView = {
        var heroimg = UIImageView()
        heroimg.contentMode = .scaleAspectFill
        heroimg.clipsToBounds = true
        heroimg.image = UIImage(named: "hero")
        return heroimg
    }()
    private func addGradient(){
        // Màu nền cho ảnh
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
        
    }
    private func applyConstraints(){
        let playbuttonconstraint = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadbuttonconstraint = [
            downloadButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -25),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(playbuttonconstraint)
        NSLayoutConstraint.activate(downloadbuttonconstraint)
    }
    
    override func layoutSubviews() {
        heroImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
