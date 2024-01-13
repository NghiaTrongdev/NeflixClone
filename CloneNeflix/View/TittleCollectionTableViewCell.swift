//
//  TittleCollectionTableViewCell.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 13/01/2024.
//

import UIKit
import SDWebImage

class TittleCollectionTableViewCell: UICollectionViewCell {

    static let identifier = "TittleCollectionTableViewCell"
    
    private let posterImage : UIImageView = {
        let cell = UIImageView()
        cell.contentMode = .scaleAspectFill
        return cell
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImage)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
        // Configure the view for the selected state
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImage.frame = contentView.bounds
    }

   
        

    public func configure(with model : String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return}
        
        posterImage.sd_setImage(with: url, completed: nil)
    }

}
