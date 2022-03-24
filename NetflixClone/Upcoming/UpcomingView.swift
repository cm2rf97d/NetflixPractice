//
//  UpcomingView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class UpcomingView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    let upcomingTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
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
        self.addSubview(upcomingTableView)
    }
    // MARK: - setLayouts
    func setLayouts() {
        upcomingTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
