//
//  StorageManager.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    public static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    private init() { }
    
    // Public
}
