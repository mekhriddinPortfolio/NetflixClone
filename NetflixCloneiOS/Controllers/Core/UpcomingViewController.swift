//
//  UpcomingViewController.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 07/06/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    var titles: [Title] = []
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(UpcomingTableViewCell.self, forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    func getUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: TitleViewModel(titleName: titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "", posterUrl: titles[indexPath.row].poster_path ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getYouTubeVideo(with: titleName) { [weak self] result in
            switch result {
            case .success(let video):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeVideo: video, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
