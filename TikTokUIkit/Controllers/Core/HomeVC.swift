//
//  HomeVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit

class HomeVC: UIViewController {
    //MARK: - Properties
    private let horizantalScrollview: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let forYouPagingController = UIPageViewController(transitionStyle: .scroll,
                                                navigationOrientation: .vertical,
                                                options: [:])
    private let followingPagingController = UIPageViewController(transitionStyle: .scroll,
                                                navigationOrientation: .vertical,
                                                options: [:])
    
    
    private let segmentedControll : UISegmentedControl = {
        let titles = ["Following", "For you"]
        let control = UISegmentedControl(items: titles)
        control.selectedSegmentIndex = 1
        control.backgroundColor = nil
        control.selectedSegmentTintColor = .white
        return control
    }()
    
    private var forYouPosts = PostModel.mockModels()
    private var followingPosts = PostModel.mockModels()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(horizantalScrollview)
        setUpFeed()
        horizantalScrollview.delegate = self
        horizantalScrollview.contentOffset = CGPoint(x: view.width, y: 0)
        setUpHeaderButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        horizantalScrollview.frame = view.bounds
        
        
    }
    
    //MARK: - Private
    private func setUpFeed() {
        horizantalScrollview.contentSize = CGSize(width: view.width * 2 , height: view.height)
        setUpFollowingFeed()
        setupForYouFeed()
        
    }
    func setUpHeaderButtons() {
        segmentedControll.addTarget(self, 
                                    action: #selector(didChangeSegmentedControl),
                                    for: .valueChanged)
        navigationItem.titleView = segmentedControll
        
        
    }
    func setUpFollowingFeed() {
        guard let model = followingPosts.first else { return }
        
        followingPagingController.setViewControllers([PostVC(model: model)],
                                            direction: .forward,
                                            animated: false)
        
        followingPagingController.dataSource = self
        
        horizantalScrollview.addSubview(followingPagingController.view)
        followingPagingController.view.frame = CGRect(x: 0, y: 0,
                                             width: horizantalScrollview.width,
                                             height: horizantalScrollview.height)
        
        
        addChild(followingPagingController)
        followingPagingController.didMove(toParent: self)
    }
    func setupForYouFeed(){
        guard let model = forYouPosts.first else { return }
        
        
        forYouPagingController.setViewControllers([PostVC(model: model)],
                                            direction: .forward,
                                            animated: false)
        
        forYouPagingController.dataSource = self
        
        horizantalScrollview.addSubview(forYouPagingController.view)
        forYouPagingController.view.frame = CGRect(x: view.width,
                                             y: 0,
                                             width: horizantalScrollview.width,
                                             height: horizantalScrollview.height)
        
        
        addChild(forYouPagingController)
        forYouPagingController.didMove(toParent: self)
        
    }
    

    //MARK: - Actions
    @objc func didChangeSegmentedControl(sender: UISegmentedControl) {
        horizantalScrollview.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
    }
    
    
    
    //MARK: - Helpers
    //MARK: - Public
    //MARK: - Private
    
}

//MARK: - UIPageViewControllerDataSource
extension HomeVC: UIPageViewControllerDataSource {
    var currentPost: [PostModel] {
        if horizantalScrollview.contentOffset.x == 0 {
            // We in Folloing
            return followingPosts
        }
        //For You
        return forYouPosts
    }
    
    // This method is part of the UIPageViewControllerDataSource protocol.
    // It returns the view controller that comes before the given view controller.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Safely unwrap the PostVC from the provided view controller.
        // If the cast fails, return nil as there's no valid view controller.
        guard let fromPost = (viewController as? PostVC)?.model else {
            return nil
        }
        
        // Find the index of the current PostModel in the array of posts.
        // If the model cannot be found, return nil.
        guard let index = currentPost.firstIndex(where: {
            $0.identifire == fromPost.identifire
        }) else {
            return nil
        }
        
        // If the current view controller is the first one, there is no previous view controller.
        if index == 0 {
            return nil
        }
        
        // Calculate the index of the previous post.
        let priorIndex = index - 1
        
        // Retrieve the previous post model from the array.
        let model = currentPost[priorIndex]
        
        // Create a new PostVC with the previous post model.
        let vc = PostVC(model: model)
        
        // Return the newly created view controller.
        return vc
    }

    
    // This method is part of the UIPageViewControllerDataSource protocol.
    // It returns the view controller that comes after the given view controller.

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // Safely unwrap the PostVC from the provided view controller.
        // If the cast fails, return nil as there's no valid view controller.
        guard let fromPost = (viewController as? PostVC)?.model else {
            return nil
        }
        
        // Find the index of the current PostModel in the array of posts.
        // If the model cannot be found, return nil.
        guard let index = currentPost.firstIndex(where: {
            $0.identifire == fromPost.identifire
        }) else {
            return nil
        }
        
        // If the current view controller is the last one, there is no next view controller.
        if index >= currentPost.count - 1 {
            return nil
        }
        
        // Calculate the index of the next post.
        let nextIndex = index + 1
        
        // Retrieve the next post model from the array.
        let model = currentPost[nextIndex]
        
        // Create a new PostVC with the next post model.
        let vc = PostVC(model: model)
        
        // Return the newly created view controller.
        return vc
    }
    
}

//MARK: - UIScrollViewDelegate
extension HomeVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let halfWidth = view.frame.width / 2
        
        if scrollView.contentOffset.x <= halfWidth {
            segmentedControll.selectedSegmentIndex = 0
        } else {
            segmentedControll.selectedSegmentIndex = 1
        }
    }
}
