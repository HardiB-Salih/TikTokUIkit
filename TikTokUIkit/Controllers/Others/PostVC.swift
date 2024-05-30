//
//  PostVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit
import AVFoundation

protocol PostVCDelegate: AnyObject {
    func postViewController(_ vc: PostVC, didTapCommentButtonFor post: PostModel)
    func postViewController(_ vc: PostVC, didTapProfileButtonFor post: PostModel)

}

class PostVC: UIViewController {
    //MARK: - Properties

    weak var delegate: PostVCDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "heart.fill") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "text.bubble.fill") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        return button
    }()
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "test") , for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.layer.cornerCurve = .continuous
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        return button
    }()
    
    private let captionLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.numberOfLines = 0
        lable.textAlignment = .left
        lable.text = "Chack out this video buddy #rr #rfffgh #ghjdj ughbgd hgdhgd vduyhbshgdvoh b jdhcugsdtyghdbd dihcyushdj"
        lable.font = .systemFont(ofSize: 20)
        return lable
    }()
    
    var player: AVPlayer?
    private var playerDidFinishObserver: NSObjectProtocol?
    
    var model: PostModel
    
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
        configureVideo()
        let colors: [UIColor] = [
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
        ]
        
        view.backgroundColor = colors.randomElement()
        
        setUpButtons()
        setUpDobbleTapToLike()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size : CGFloat = 40
        let yStart: CGFloat = view.height - (size * 5) - 40 - view.safeAreaInsets.bottom - (tabBarController?.tabBar.height ?? 0)
        let buttons = [profileButton, likeButton, commentButton, shareButton]
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: view.width-size-10,
                                  y: yStart + (CGFloat(index) * 10) + (CGFloat(index) * size),
                                  width: size,
                                  height: size)
        }
        
        captionLable.sizeToFit()
        let lableSize = captionLable.sizeThatFits(CGSize(width: view.width - size - 12, height: view.height))
        captionLable.frame = CGRect(x: 5,
                                    y: view.height - view.safeAreaInsets.bottom - lableSize.height - (tabBarController?.tabBar.height ?? 0) - 30,
                                    width: view.width - size - 12,
                                    height: lableSize.height)


        
    }
    
    
    //MARK: - Actions
    @objc private func didTapProfile() {
        delegate?.postViewController(self, didTapProfileButtonFor: model)
    }
    
    @objc private func didTapLike() {
        model.isLikedByCurrentUser = !model.isLikedByCurrentUser
        likeButton.tintColor = model.isLikedByCurrentUser ? .systemRed : .white
    }
    @objc private func didTapComment() {
        delegate?.postViewController(self, didTapCommentButtonFor: model)
    }
    @objc private func didTapShare() {
        guard let url = URL(string: "https://tiktok.com") else { return }
        
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true)
    }
    
    
    
    @objc private func didDobbleTap(_ gesture: UITapGestureRecognizer) {
        
        if !model.isLikedByCurrentUser {
            model.isLikedByCurrentUser = true
        }
        
        let touchPoint = gesture.location(in: view)
        let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imageView.tintColor = .systemRed
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = touchPoint
        imageView.contentMode = .scaleAspectFit
        imageView.alpha = 0
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.2) {
            imageView.alpha = 1
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
                    UIView.animate(withDuration: 0.2) {
                        imageView.alpha = 0
                    } completion: { done in
                        if done {
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }

    //MARK: - Helpers
    func setUpButtons(){
        view.addSubview(profileButton)
        view.addSubview(likeButton)
        view.addSubview(commentButton)
        view.addSubview(shareButton)
        view.addSubview(captionLable)
        
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    func setUpDobbleTapToLike() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDobbleTap(_:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    //MARK: - Public
    //MARK: - Private
    private func  configureVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else { return }
        let url = URL(fileURLWithPath: path)
        
        player = AVPlayer(url: url)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        
        guard let player = player else {
            return
        }
        player.volume = 0
        player.play()
        
        
        playerDidFinishObserver = NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: player.currentItem, queue: .main, using: { _ in
            player.seek(to: .zero)
            player.play()
        })
    }



}
