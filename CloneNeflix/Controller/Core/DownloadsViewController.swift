//
//  DownloadsViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class DownloadsViewController: UIViewController {
    private var titles : [TitleItem] = [TitleItem]()
    private let tableView : UITableView = {
       let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.indentifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Download"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        FetchData()
        NotificationCenter.default.addObserver(forName: Notification.Name("Downloaded"), object: nil, queue: nil){_ in
            self.FetchData()
            
        }
    }
    private func FetchData(){
        DataPersistenceManager.shared.fetchingfromDatabase{result in
            switch result {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print (error.localizedDescription)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}
extension DownloadsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.indentifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleModel(titleName: title.original_title ?? title.original_name ?? "Unkhnown", posterImage: title.poster_path ?? ""))
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            
            
            DataPersistenceManager.shared.DeleteTitleItemFromDatabase(model: titles[indexPath.row]){[weak self] result in
                switch result{
                case .success():
                    print("Delete Completed")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
         default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Huỷ sự kiện hàng được chọn tức là tắt highlight trên hàng đó
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_name ?? title.original_title  else {
            return
        }
        APICaller.shared.getMovie(with: titleName){[weak self] result in
            switch result{
            case.success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitllePreviewViewController()
                    vc.configView(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    
    
}
