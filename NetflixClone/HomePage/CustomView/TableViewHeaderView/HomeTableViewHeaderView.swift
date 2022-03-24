//
//  HomeTableViewHeaderView.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class HomeTableViewHeaderView: UIView {
    // MARK: - Properties
    // MARK: - IBOutLets
    lazy var tableViewHeaderView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let playButton: HomeTableViewHeaderViewButton = HomeTableViewHeaderViewButton.button(title: "Play")
    let downloadButton: HomeTableViewHeaderViewButton = HomeTableViewHeaderViewButton.button(title: "Download")
        
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
    func configure(headPosterURL: String) {
        guard let url: URL = URL(string: "https://image.tmdb.org/t/p/w500\(headPosterURL)") else { return }
        tableViewHeaderView.sd_setImage(with: url, completed: nil)
    }
    
    // MARK: - setViews
    private func setViews() {
        self.addSubview(tableViewHeaderView)
        tableViewHeaderView.addSubview(playButton)
        tableViewHeaderView.addSubview(downloadButton)
    }
    
    // MARK: - setLayouts
    private func setLayouts() {
        tableViewHeaderView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(tableViewHeaderView.snp.leading).offset(70)
            make.bottom.equalTo(tableViewHeaderView.snp.bottom).offset(-30)
            make.width.equalTo(100)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-70)
            make.width.bottom.equalTo(playButton)
        }
    }
}
