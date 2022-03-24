//
//  UpcomingTableViewCell.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/1.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = "UpcomingTableViewCell"
    
    // MARK: - IBOutLets
    private let posterImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let posterLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let playButton: UIButton = {
        let button: UIButton = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        button.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - setViews
    func setViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(posterLabel)
        contentView.addSubview(playButton)
    }
    
    // MARK: - setLayouts
    func setLayouts() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(100)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.trailing.equalTo(playButton.snp.leading).offset(-10)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-20)
        }
    }
    
    //MARK: - function
    func configure(with model: TitleViewModel) {
        guard let url: URL = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        posterLabel.text = model.titleName
    }
}
