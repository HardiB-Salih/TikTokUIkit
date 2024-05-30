//
//  ProfileVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - Properties
    let user: User
    
    //MARK: - Init
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.username.uppercased()
        view.backgroundColor = .systemBackground
    }
    
    //MARK: - Actions
    //MARK: - Helpers
    //MARK: - Public
    //MARK: - Private
    
}
