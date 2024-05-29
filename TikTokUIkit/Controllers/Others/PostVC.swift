//
//  PostVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit

class PostVC: UIViewController {
    //MARK: - Properties
   
    let model: PostModel
    
    //MARK: - Lifecycle
    init(model: PostModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors: [UIColor] = [
            .red,
            .blue,
            .green,
            .yellow,
            .orange,
            .purple,
            .brown,
            .cyan,
            .magenta,
            .gray,
            .black,
            .white
        ]
        
        view.backgroundColor = colors.randomElement()
    }
    //MARK: - Actions
    //MARK: - Helpers
    //MARK: - Public
    //MARK: - Private



}
