//
//  TableViewSectionModel.swift
//  NetflixClone
//
//  Created by 陳郁勳 on 2022/3/1.
//

enum Sections: Int, CaseIterable {
    case trendingMovies = 0
    case trendingTvs = 1
    case popularMovies = 2
    case upcomingMovies = 3
    case topRateMovies = 4
    
    var sectionTitle: String {
        switch self {
        case .trendingMovies:
            return "Trending Movies"
        case .trendingTvs:
            return "Trending Tv"
        case .popularMovies:
            return "Popular Movies"
        case .upcomingMovies:
            return "Upcoming Movies"
        case .topRateMovies:
            return "Top Rate Movies"
        }
    }
}
