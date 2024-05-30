//
//  Extensions.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
    
    
}

extension DateFormatter {
    static let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

extension String {
    static func date(with date: Date) -> String {
        return DateFormatter.defaultFormatter.string(from: date)
    }
}


extension UIView {
    // Method to get the height of the main view considering navigation bar, tab bar, and safe area insets
    var mainHeight: CGFloat {
        var height = self.bounds.height
        
        if let viewController = self.parentViewController {
            // Subtract navigation bar height
            if let navigationController = viewController.navigationController {
                height -= navigationController.navigationBar.frame.height
            }
            
            // Subtract status bar height
            if let statusBarHeight = getStatusBarHeight() {
                height -= statusBarHeight
            }
            
            // Subtract tab bar height
            if let tabBarController = viewController.tabBarController {
                height -= tabBarController.tabBar.frame.height
            }
        }
        
        // Subtract safe area insets
        if #available(iOS 11.0, *) {
            height -= self.safeAreaInsets.top
            height -= self.safeAreaInsets.bottom
        }
        
        return height
    }
    
    // Method to get the width of the main view considering safe area insets
    var mainWidth: CGFloat {
        var width = self.bounds.width
        
        // Subtract safe area insets
        if #available(iOS 11.0, *) {
            width -= self.safeAreaInsets.left
            width -= self.safeAreaInsets.right
        }
        
        return width
    }
    
    // Helper method to get the status bar height
    private func getStatusBarHeight() -> CGFloat? {
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            return windowScene?.statusBarManager?.statusBarFrame.height
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    // Helper property to get the parent view controller
    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
