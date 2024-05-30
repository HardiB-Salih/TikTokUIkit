//
//  ExploreHashtagViewModel.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/30/24.
//

import UIKit

struct ExploreHashtagViewModel {
    let title: String
    let icon: UIImage?
    let count: Int // number of posts associated with tag
    let handler: (() -> Void)
}
