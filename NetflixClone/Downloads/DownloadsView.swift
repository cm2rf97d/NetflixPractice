//
//  DownloadsView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class DownloadsView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    let downloadsTableView: UITableView = {
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
        addSubview(downloadsTableView)
    }
    
    // MARK: - setLayouts
    func setLayouts() {
        downloadsTableView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
