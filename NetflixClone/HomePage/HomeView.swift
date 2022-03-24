//
//  HomeView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit
import SnapKit

class HomeView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    let homeTableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    let navigationLeftButton: UIButton = {
        let button: UIButton = UIButton(type: .custom)
        button.tintColor = .red
        return button
    }()
    
    lazy var tableViewHeaderView: HomeTableViewHeaderView = HomeTableViewHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 450))
    
    private let loadingView: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView = UIActivityIndicatorView()
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3, y: 3)
        view.transform = transform
        view.style = .medium
        view.color = .white
        view.backgroundColor = .black
        view.hidesWhenStopped = true
        return view
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
    func loadingViewStartAnimating() {
        loadingView.startAnimating()
    }
    
    func loadingViewStopAnimating() {
        loadingView.stopAnimating()
    }
    
    // MARK: - setViews
    private func setViews() {
        addSubview(homeTableView)
        addSubview(tableViewHeaderView)
        addSubview(loadingView)
    }
    
    // MARK: - setLayouts
    private func setLayouts() {
        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        navigationLeftButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.height.width.equalTo(25)
        }
    }
}
