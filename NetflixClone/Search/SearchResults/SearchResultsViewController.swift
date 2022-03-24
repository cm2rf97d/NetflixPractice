//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/16.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTap(model: TitlePreviewModel)
}

class SearchResultsViewController: UIViewController {
    // MARK: - Properties
    private let searchResultsView: SearchResultsView = SearchResultsView()
    weak var delegate: SearchResultsViewControllerDelegate?
    var titles: [Title] = [] {
        didSet {
            searchResultsView.mainCollectionView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewDelegate()
    }
    
    override func loadView() {
        super.loadView()
        self.view = searchResultsView
    }
    
    // MARK: - Function
    private func setCollectionViewDelegate() {
        searchResultsView.mainCollectionView.delegate = self
        searchResultsView.mainCollectionView.dataSource = self
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: TitleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        let title: Title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title: Title = titles[indexPath.row]
        guard let titleName: String = title.original_title ?? title.original_name else { return }
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResultsViewControllerDidTap(model: TitlePreviewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
