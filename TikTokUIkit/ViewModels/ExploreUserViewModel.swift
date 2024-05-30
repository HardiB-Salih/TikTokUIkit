//
//  ExploreUserViewModel.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/30/24.
//

import UIKit

struct ExploreUserViewModel {
    let profilePicture: URL?
    let username: String
    let followingCount: Int
    let handler: (() -> Void)
}
