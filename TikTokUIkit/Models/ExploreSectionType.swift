//
//  ExploreSectionType.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/30/24.
//

import Foundation

enum ExploreSectionType: CaseIterable {
    case banner
    case trendingPosts
    case users
    case trendingHashtags
    case recomended
    case popular
    case new
    
    var title: String {
        switch self {
        case .banner:
            return "Featured"
        case .trendingPosts:
            return "Treanding Videos"
        case .users:
            return "Popular Creators"
        case .trendingHashtags:
            return "Hashtags"
        case .recomended:
            return "Recomended"
        case .popular:
            return "Popular"
        case .new:
            return "Recently Posted"
        }
    }
}
