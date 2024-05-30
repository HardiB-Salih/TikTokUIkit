//
//  PostModel.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import Foundation
struct PostModel { 
    let identifire: String
    var isLikedByCurrentUser: Bool = false
    let user = User(username: "kanyewest",
                    profilePictureURL: nil,
                    identifier: UUID().uuidString)
    
    static func mockModels() -> [PostModel] {
        return (0..<100).map { _ in PostModel(identifire: UUID().uuidString) }
    }
}
