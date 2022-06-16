//
//  SearchResultsViewController.swift
//  NetflixCloneiOS
//
//  Created by Mekhriddin on 10/06/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDelegateDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    var titles: [Title] = []
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    let searchResultsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }

}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        APICaller.shared.getYouTubeVideo(with: titleName) { [weak self] result in
            switch result {
            case .success(let video):
                self?.delegate?.searchResultsViewControllerDelegateDidTapItem(TitlePreviewViewModel(title: titleName, youtubeVideo: video, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error)
            }
        }
    }
}

