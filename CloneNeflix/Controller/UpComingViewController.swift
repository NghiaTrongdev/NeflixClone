//
//  UpComingViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class UpComingViewController: UIViewController {
    private var titles : [Title] = [Title]()
    
        private let upComingTableView : UITableView = {
           let comingtableView = UITableView()
            
            comingtableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.indentifier)
            return comingtableView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        getVideoUpcoming()
        
        view.addSubview(upComingTableView)
        upComingTableView.dataSource = self
        upComingTableView.delegate = self
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upComingTableView.frame = view.bounds
    }

    
    /*
    [weak self] là một cơ chế trong Swift để tránh vấn đề retain cycle (vòng lặp giữa các tham chiếu strong) trong các closure. Khi bạn sử dụng self trong một closure, đặc biệt là trong môi trường không đồng bộ như khi làm việc với networking hoặc các tác vụ bất đồng bộ khác, có thể xảy ra vấn đề về memory leak nếu không sử dụng [weak self] để tránh vấn đề này.

    Khi bạn sử dụng [weak self], bạn đang nói với Swift rằng "nếu self không còn tồn tại (ví dụ: nếu view controller đã bị giải phóng bộ nhớ), thì không giữ reference strong tới self". Điều này giúp tránh vấn đề retain cycle và giúp giải phóng bộ nhớ đúng cách khi đối tượng không còn được sử dụng nữa.

    Trong trường hợp của đoạn mã bạn đưa ra, [weak self] được sử dụng trong closure của hàm getUpcoming, giúp tránh vấn đề retain cycle khi xử lý kết quả từ hàm này.
*/
    private func getVideoUpcoming(){
     
        API_Caller.shared.getUpcoming {[weak self] results in
            switch results {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upComingTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

  
}
extension UpComingViewController : UITableViewDataSource , UITableViewDelegate {
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
   
}
