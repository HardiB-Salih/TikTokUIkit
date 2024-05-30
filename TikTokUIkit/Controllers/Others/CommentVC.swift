//
//  CommentVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit

protocol CommentVCDelegate: AnyObject {
    func didTapCloseForComment(for vc: CommentVC)
}

class CommentVC: UIViewController {
    let poat: PostModel
    var comments = [PostComment]()
    weak var delegate: CommentVCDelegate?
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemMint
        button.setBackgroundImage(UIImage(systemName: "xmark.circle.fill") , for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CommentCell.self, forCellReuseIdentifier: CommentCell.idenrifier)
        return table
    }()
    
    
    init(post: PostModel) {
        self.poat = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(closeButton)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        fetchPostComment()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        closeButton.frame = CGRect(x: view.width - 60, y: 10, width: 40, height: 40)
        tableView.frame = CGRect(x: 0, y: closeButton.bottom, width: view.width, height: view.height)
    }
    
    @objc func didTapClose() {
        delegate?.didTapCloseForComment(for: self)
    }
    
    func fetchPostComment()  {
        comments = PostComment.mockCommets()
    }
}

extension CommentVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.idenrifier, for: indexPath) as? CommentCell else { return UITableViewCell()}
        
        let comment = comments[indexPath.row]
        cell.configure(with: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
