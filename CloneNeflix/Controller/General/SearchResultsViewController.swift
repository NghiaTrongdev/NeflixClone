//
//  SearchResultsViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 15/01/2024.
//

import UIKit

class SearchResultsViewController: UIViewController {
    public var titles : [Title] = [Title]()
    
    public let testView : UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TittleCollectionTableViewCell.self, forCellWithReuseIdentifier: TittleCollectionTableViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGreen
        view.addSubview(testView)
        
        testView.dataSource = self
        testView.delegate = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testView.frame = view.bounds
    }
    

}

extension SearchResultsViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TittleCollectionTableViewCell.identifier, for: indexPath) as? TittleCollectionTableViewCell else {

            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
    
    
}
