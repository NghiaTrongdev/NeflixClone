//
//  SearchViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    private var titles : [Title] = [Title]()
    
    private let tableSearchView : UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.indentifier)
        return table
    }()

    private let searchController : UISearchController  = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Dell co cai lon gi ca"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground

        
        view.addSubview(tableSearchView)
        tableSearchView.dataSource = self
        tableSearchView.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
       
        setData()
        // Kết quả sau khi gõ ô search được hiện tại viewcontroller này
        searchController.searchResultsUpdater = self
    }
    
   
    private func setData() {
        APICaller.shared.getDiscoverMovies{[weak self] results in
            switch results {
            case .success(let model):
                self?.titles = model
                DispatchQueue.main.async {
                    self?.tableSearchView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableSearchView.frame = view.bounds
        
    }
    
}
extension SearchViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableSearchView.dequeueReusableCell(withIdentifier: TitleTableViewCell.indentifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: TitleModel(titleName: title.original_title ?? title.original_name ?? "Unkhnown", posterImage: title.poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_name ?? title.original_title else {
            return
        }
        // search dữ liệu bằng youtube api , sau đó trả về phần tử
        APICaller.shared.getMovie(with: titleName){[weak self] result in
            switch result{
            case .success(let videoElement):
                DispatchQueue.main.async{
                    let vc = TitllePreviewViewController()
                    vc.configView(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? " "))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchViewController : UISearchResultsUpdating , SearchResultsViewControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        resultsController.delegate = self
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.testView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func SearchResultsViewControllerDidTapped(_ viewmodel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async{ [weak self] in
            let vc = TitllePreviewViewController()
            vc.configView(with: viewmodel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

    
    

