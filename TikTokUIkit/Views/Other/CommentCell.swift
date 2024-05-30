//
//  CommentCell.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/30/24.
//

import UIKit

class CommentCell: UITableViewCell {
    static let idenrifier = "CommentCell"
    
    private let avatarImageview : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 14
        imageView.layer.cornerCurve = .continuous
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .bold)
        lable.numberOfLines = 1
        lable.textColor = .label
        return lable
    }()
    
    private let commentLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 16, weight: .regular)
        lable.numberOfLines = 1
        lable.textColor = .label.withAlphaComponent(0.8)
        return lable
    }()
    
    private let dateLable: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 12, weight: .light)
        lable.numberOfLines = 1
        lable.textColor = .secondaryLabel
        return lable
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        
        addSubview(avatarImageview)
        addSubview(usernameLable)
        addSubview(commentLable)
        addSubview(dateLable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        commentLable.sizeToFit()
        dateLable.sizeToFit()
        usernameLable.sizeToFit()
        
        avatarImageview.frame = CGRect(x: 10, y: 10, width: 44, height: 44)
        usernameLable.frame = CGRect(x: avatarImageview.right + 10,
                                     y: 10,
                                     width: usernameLable.width,
                                     height: usernameLable.height)
        
        
        
        commentLable.frame = CGRect(x: avatarImageview.right + 10,
                                    y: usernameLable.bottom + 5,
                                    width: commentLable.width,
                                    height: commentLable.height)
        
        dateLable.frame = CGRect(x: 10,
                                 y: contentView.height - dateLable.height - 5,
                                 width: dateLable.width, height: dateLable.height)
        
        
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageview.image = nil
        commentLable.text = nil
        usernameLable.text = nil
        dateLable.text = nil
    }
    
    public func configure(with model: PostComment) {
        commentLable.text = model.text
        usernameLable.text = model.user.username
        dateLable.text = .date(with: model.date)
        avatarImageview.image = #imageLiteral(resourceName: "Logo")
        // Dont Forget to set the image
    }
    
}
