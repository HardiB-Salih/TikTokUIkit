//
//  ExploreVC.swift
//  TikTokUIkit
//
//  Created by HardiB.Salih on 5/29/24.
//

import UIKit


class ExploreVC: UIViewController {
    //MARK: - Properties
    private let  searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search..."
        bar.layer.cornerRadius = 8
        bar.layer.cornerCurve = .continuous
        bar.layer.masksToBounds = true
        return bar
    }()
    
    private var collectionView : UICollectionView?
    private var sections = [ExploreSection]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureModels()
        setUpSerachBar()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    //MARK: - Actions
    //MARK: - Public
    //MARK: - Private
    private func setUpSerachBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { section, _ -> NSCollectionLayoutSection? in
            
            return self.layout(for: section)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    func layout(for section: Int) -> NSCollectionLayoutSection {
        let sectionType = sections[section].type
        
        switch sectionType {
        case .banner:
            return bannerLayout()
        case .users:
            return usersLayout()
        case .trendingHashtags:
            return trendingHashtagsLayout()
        case .trendingPosts, .recomended, .new:
            return postsLayout()
        case .popular:
            return PopularPostsLayout()
        }
    }
    
    func bannerLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)),
                                                       subitems: [item])
        
        // Section layout
        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        // Return
        return sectionLayout
    }
    func usersLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(200),
            heightDimension: .absolute(200)),
                                                       subitems: [item])
        
        // Section layout
        let sectionLayout = NSCollectionLayoutSection(group: group)
        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        // Return
        return sectionLayout
    }
    func trendingHashtagsLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
//        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .absolute(240),
//            heightDimension: .absolute(180)),
//                                                             subitem: item,
//                                                             count: 3)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
        
        // Section layout
        let sectionLayout = NSCollectionLayoutSection(group: group)
//        sectionLayout.orthogonalScrollingBehavior = .groupPaging
        // Return
        return sectionLayout
    }
    
    func postsLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(100),
            heightDimension: .absolute(240)),
                                                             subitem: item, count: 2
        )
        
        let horizantalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(240)), subitems: [verticalGroup])
        
        // Section layout
        let sectionLayout = NSCollectionLayoutSection(group: horizantalGroup)
        sectionLayout.orthogonalScrollingBehavior = .continuous
        // Return
        return sectionLayout
    }
    func PopularPostsLayout() -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        // Group
        let horizantalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(200)), subitems: [item])
        
        // Section layout
        let sectionLayout = NSCollectionLayoutSection(group: horizantalGroup)
        sectionLayout.orthogonalScrollingBehavior = .continuous
        // Return
        return sectionLayout
    }
    
    
    
    private func configureModels() {
        var cells = [ExploreCell]()
        for x in 0...100 {
            let cell = ExploreCell.banner(viewModel: ExploreBannerViewModel(image: nil, title: "Foo", handler: {}))
            cells.append(cell)
        }
        
        //banner
        sections.append(ExploreSection(type: .banner,
                                       cells: cells))
        
        //trendingPosts
        sections.append(ExploreSection(type: .trendingPosts, cells:
                                        Array(repeating: .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {})), count: 10)))
        
        
        
        //users
        sections.append(ExploreSection(type: .users,
                                       cells: Array(repeating: .user(viewModel: ExploreUserViewModel(profilePicture: nil, username: "", followingCount: 0, handler: {})), count: 10)))
        
        //trendingHashtags
        sections.append(ExploreSection(type: .trendingHashtags,
                                       cells: Array(repeating: .hashtag(viewModel: ExploreHashtagViewModel(title: "", icon: nil, count: 1, handler: {})), count: 10)
                                      ))
        
        //recomended
        sections.append(ExploreSection(type: .recomended, cells:
                                        Array(repeating: .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {})), count: 10)
                                      ))
        
        //popular
        sections.append(ExploreSection(type: .popular, cells: Array(repeating: .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {})), count: 10)))
        
        //new
        sections.append(ExploreSection(type: .new, cells: Array(repeating: .post(viewModel: ExplorePostViewModel(thumbnailImage: nil, caption: "", handler: {})), count: 10)))
        
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ExploreVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let model = sections[indexPath.section].cells[indexPath.row]
        
        switch model {
        case .banner(let viewModel):
            break
        case .post(let viewModel):
            break
        case .hashtag(let viewModel):
            break
        case .user(let viewModel):
            break
        }
        cell.backgroundColor = .red
        return cell
    }
    
    
}

//MARK: - UISearchBarDelegate
extension ExploreVC : UISearchBarDelegate {
    
}
