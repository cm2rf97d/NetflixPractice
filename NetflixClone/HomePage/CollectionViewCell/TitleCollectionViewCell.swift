//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/25.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier: String = "TitleCollectionViewCell"
    
    // MARK: - IBLayouts
    private let posterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Initial
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Function
    func configure(with model: String) {
        guard let url: URL = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    // MARK: - SetViews
    private func setViews() {
        contentView.addSubview(posterImageView)
    }
    
    // MARK: - SetLayouts
    private func setLayouts() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
