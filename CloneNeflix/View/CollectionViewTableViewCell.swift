//
//  CollectionViewTableViewCell.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    private var titles : [Title] = [Title]()
    static var identifier = "CollectionViewTableViewCell"
    
    private var collectionview : UICollectionView = {
        // Khoi tao layout de tung o cua hang duoc thuc hien sap xep theo layout (Flowlayout)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        // Set thuoc tinh cuon cua du lieu theo chieu ngang
        layout.scrollDirection = .horizontal
        
        // khoi tao doi tuong UICollectionView voi kich thuoc ban
        //dau bang khong va layout = layout ta da khai bao o tren
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // đăng ký 1 UICollectionViewCell subclas cho collectionview ,
        collectionview.register(TittleCollectionTableViewCell.self , forCellWithReuseIdentifier: TittleCollectionTableViewCell.identifier)
        return collectionview
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        // them collectionview vao lop CollectionViewTableCell de co the hien thi ra ngoai
        contentView.addSubview(collectionview)
        
        // du lieu va hanh dong duoc quan li
        collectionview.dataSource = self
        collectionview.delegate = self
        
    }
    
    // hàm này luôn đi cùng hàm override ở phía trên để log error
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Việc này đảm bảo rằng collectionView sẽ lấp đầy toàn bộ kích thước của view, đồng thời thích nghi với bất kỳ thay đổi kích thước nào của view cha.
        collectionview.frame = contentView.bounds
    }
    public func setTitle(with titles :[Title]){
        self.titles = titles
        
        DispatchQueue.main.async {
            [weak self] in
            self?.collectionview.reloadData()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CollectionViewTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Trả về số lượng cell trên một hàng của collectionView
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Khai báo ra một đối tượng cell sẽ được dùng lại sau đó với ô được select = index Path
        // và khai báo
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TittleCollectionTableViewCell.identifier, for: indexPath) as? TittleCollectionTableViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    
    
}
