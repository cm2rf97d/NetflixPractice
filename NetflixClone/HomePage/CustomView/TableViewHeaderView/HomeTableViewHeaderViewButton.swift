//
//  HomeTableViewHeaderViewButton.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/2/22.
//

import UIKit

class HomeTableViewHeaderViewButton: UIButton {
    
    static func button(title: String) -> HomeTableViewHeaderViewButton{
        let button: HomeTableViewHeaderViewButton = {
            let button: HomeTableViewHeaderViewButton = HomeTableViewHeaderViewButton()
            button.setTitle(title, for: .normal)
            button.backgroundColor = .black
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 10
            return button
        }()
        return button
    }
}
