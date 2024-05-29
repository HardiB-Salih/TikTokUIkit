//
//  HapticsManager.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import Foundation
import UIKit

final class HapticsManager {
    public static let shared = HapticsManager()
    private init() { }
    
    // Public
    public func vibrateForSelection() {
        DispatchQueue.main.sync {
            let genarator = UISelectionFeedbackGenerator()
            genarator.prepare()
            genarator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.sync {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }

    
}
