//
//  HomeViewController.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 11/01/2024.
//

import UIKit

class HomeViewController: UIViewController {
    //  Khai bao cac header cho tung Cell
    private var sessionTitles : [String] = ["Trending Movies","Popular","Trending Tv","Upcoming Movies","Top Rated"]
    
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
        let headerview = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        
        // Xác định phần ở trên của table view là header được khai báo ở trên
        hometable.tableHeaderView = headerview
        
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

}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sessionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
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
        var defaultOffset = view.safeAreaInsets.top
        
        var offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sessionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x , y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }
}
