//
//  UpcomingViewModel.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/1.
//

import Foundation

struct TitleViewModel {
    let titleName: String
    let posterURL: String
    
    init(titleName: String,
         posterURL: String) {
        
        self.titleName = titleName
        self.posterURL = posterURL
    }
}
