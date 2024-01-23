//
//  HomeViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case UpcomingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTitle : Title?
    
    private var headerView :HeroHeaderView?
    
    //  Khai bao cac header cho tung Cell
    private var sectionTitles : [String] = ["Trending Movies","Trending Tv","Popular","Upcoming Movies","Top Rated"]
    
    // Khai bao table ke thua UITabelview
    private let hometable: UITableView = {
        // tạo biến table với khởi tạo fram ban đầu bằng không và .grouped được sử dụng để tạo ra các phần đường viền và nền nhóm để phân chia giữa các nhóm dữ liệu.
        let table = UITableView(frame: .zero , style: .grouped)
        
        // Đăng ký một lớp cell tuỳ chỉnh và đăng ký tái sử dụng lại 
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // xác định dữ liệu và điều khiển được thêm vào
        view.addSubview(hometable)
        hometable.dataSource = self
        hometable.delegate = self
        
        // Gọi hàm tuỳ chỉnh lại navbar
        configureNavbarlogo()
        
        // Khai báo phần header được tự cấu hình và được xác định từ ví trí gốc và có độ lớn 450 points
        headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        
        // Xác định phần ở trên của table view là header được khai báo ở trên
        hometable.tableHeaderView = headerView
        configHeaderView()
       
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         // Xác định kích thước của home table bằng chính kích thước của view toàn bộ
        hometable.frame = view.bounds
    }
    
    // Tạo hàm tuỳ chỉnh lại thành phần Navbar logo
    private func configureNavbarlogo(){
        // tạo ra biến img đại diện cho logo netflix
        var img = UIImage(named: "netflixLogo")
        // chỉnh cho ảnh sẽ giữ nguyên trạng thái như lúc đầu không bị màu nền ảnh hưởng
        img = img?.withRenderingMode(.alwaysOriginal)
        
        // Cho vị trí của img sẽ là nút bên trái của thanh navbar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img, style: .done, target: self, action: nil)
        
        // Tạo ra 2 nút bên phải đại diện cho tài khoản và videos
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle.fill"), style: .done, target: self, action: nil)
        ]
        // xét màu cho thanh navigation là trắng
        navigationController?.navigationBar.tintColor = .white
    }
    func configHeaderView(){
        APICaller.shared.getTrendingMovies{ [weak self] result in
            switch result{
            case .success(let model):
                let randum = model.randomElement()
                self?.randomTitle = randum
                
                self?.headerView?.configImage(with: TitleModel(titleName: randum?.original_title ?? randum?.original_name ?? "Unkhnown", posterImage: randum?.poster_path ?? "") )
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue :
            APICaller.shared.getTrendingMovies{ results in
                switch results {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue :
            APICaller.shared.getTrendingTvs { results in
                switch results {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue :
            APICaller.shared.getPopular{ results in
                switch results {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.UpcomingMovies.rawValue :
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue :
            APICaller.shared.getTopRated { results in
                switch results {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    // sự kiện cuộn màn hình
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Độ dài của màn safeArea
        let defaultOffset = view.safeAreaInsets.top
        
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.upperFirstChar()
    }
}

extension HomeViewController : CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitllePreviewViewController()
            vc.configView(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
