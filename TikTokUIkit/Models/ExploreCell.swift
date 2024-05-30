//
//  ExploreCell.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/30/24.
//

import UIKit

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashtagViewModel)
    case user(viewModel: ExploreUserViewModel)
}



