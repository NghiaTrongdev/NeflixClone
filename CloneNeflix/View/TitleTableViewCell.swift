//
//  TitleTableViewCell.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 13/01/2024.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let indentifier = "TitleTableViewCell"
    
    private let posterImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private let playButton : UIButton = {
        let button = UIButton()
        let img = UIImage(systemName: "play.circle",withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(img, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(playButton)
        contentView.addSubview(titleLabel)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConstraints(){
        let titlePosterImageConstraints = [
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelViewContraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        let buttonPlayConstraints = [
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        
        ]
        NSLayoutConstraint.activate(titlePosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelViewContraints)
        NSLayoutConstraint.activate(buttonPlayConstraints)
    }
    
    public func configure(with model : TitleModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterImage)") else {return}
        posterImageView.sd_setImage(with: url , completed: nil)
        titleLabel.text = model.titleName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
