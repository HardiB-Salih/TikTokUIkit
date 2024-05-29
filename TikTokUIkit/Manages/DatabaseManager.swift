//
//  DatabaseManager.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager {
    public static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    private init() { }
    
    //Public
}
