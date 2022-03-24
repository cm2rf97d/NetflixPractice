//
//  SearchView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class SearchView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    let searchTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    let searchController: UISearchController = {
        let controller: UISearchController = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a TV show."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Function
    // MARK: - setViews
    func setViews() {
        self.addSubview(searchTableView)
    }
    
    // MARK: - setLayouts
    func setLayouts() {
        searchTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
