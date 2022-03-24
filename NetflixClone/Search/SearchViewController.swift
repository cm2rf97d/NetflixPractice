//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    private let searchView: SearchView = SearchView()
    private var titles: [Title] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTableViewDelegate()
        getDiscoverMovies()
        setSearchControllerUpdater()
    }
    
    override func loadView() {
        self.view = searchView
    }
    
    // MARK: - Function
    private func setNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.searchController = searchView.searchController
    }
    
    private func setTableViewDelegate() {
        searchView.searchTableView.delegate = self
        searchView.searchTableView.dataSource = self
    }
    
    private func setSearchControllerUpdater() {
        searchView.searchController.searchResultsUpdater = self
    }
    
    // MARK: - Get Discover Movies
    private func getDiscoverMovies() {
        APICaller.shared.getDiscoverMovies { [weak self]result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.searchView.searchTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Search movies
    fileprivate func searchMovieOrTV(query: String, searchResultsController: SearchResultsViewController) {
        APICaller.shared.searchMovieOrTV(with: query) { results in
            DispatchQueue.main.async {
                switch results {
                case .success(let titles):
                    searchResultsController.titles = titles
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}

// MARK: - Table veiw delegate
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        let title: Title = titles[indexPath.row]
        let viewModel: TitleViewModel = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "",
                                                       posterURL: title.poster_path ?? "")
        cell.configure(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title: Title = titles[indexPath.row]
        guard let titleName: String = title.original_title ?? title.original_name else { return }
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.model = TitlePreviewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? "")
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        resultsController.delegate = self
        searchMovieOrTV(query: query, searchResultsController: resultsController)
    }
    
    func searchResultsViewControllerDidTap(model: TitlePreviewModel) {
        DispatchQueue.main.async {
            let vc: TitlePreviewViewController = TitlePreviewViewController()
            vc.model = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
