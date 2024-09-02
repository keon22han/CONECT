import UIKit


class SecondHandViewController: UIViewController {
    
    var sortingCriteria = SortingCriteria.latest
    
    
    let topView = UIView()
    let topLineView = UIView()
    let latestButton = UIButton()
    let accuracyButton = UIButton()
    let uploadPostButton = UIButton()
    let contentScrollView = UIScrollView()
    let contentStackView = UIStackView()
    let contentSearchButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)

        self.topView.translatesAutoresizingMaskIntoConstraints = false
        self.topLineView.translatesAutoresizingMaskIntoConstraints = false
        self.latestButton.translatesAutoresizingMaskIntoConstraints = false
        self.accuracyButton.translatesAutoresizingMaskIntoConstraints = false
        self.uploadPostButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentSearchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.topView.backgroundColor = .white
        self.view.addSubview(self.topView)
        
        self.topLineView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        self.view.addSubview(self.topLineView)
        
        self.latestButton.setTitle(" • 최신순", for: .normal)
        self.latestButton.titleLabel!.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.latestButton.setTitleColor(UIColor.systemOrange, for: .normal)
        self.latestButton.addTarget(self, action: #selector(latestButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.latestButton)
        
        self.accuracyButton.setTitle("• 관련도순 (검색)", for: .normal)
        self.accuracyButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 13)
        self.accuracyButton.setTitleColor(UIColor.lightGray, for: .normal)
        self.accuracyButton.addTarget(self, action: #selector(accuracyButtonClicked), for: .touchUpInside)
        self.view.addSubview(self.accuracyButton)
        
        self.uploadPostButton.backgroundColor = UIColor(red: 36/255, green: 106/255, blue: 176/255, alpha: 1)
        self.uploadPostButton.setTitle("게시글 올리기", for: .normal)
        self.uploadPostButton.layer.cornerRadius = 10
        self.uploadPostButton.layer.shadowColor = UIColor.black.cgColor
        self.uploadPostButton.layer.shadowOpacity = 0.5
        self.uploadPostButton.layer.shadowRadius = 3
        self.uploadPostButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.uploadPostButton.layer.masksToBounds = true
        self.uploadPostButton.setTitleColor(.white, for: .normal)
        self.uploadPostButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 12)
        self.uploadPostButton.addTarget(self, action: #selector(uploadPostButtonClicked), for: .touchUpInside)
        self.topView.addSubview(self.uploadPostButton)
        
        // TODO: 검색 기능은 관련도 순 클릭으로 (2024.09.02)
//        self.contentSearchButton.setImage(UIImage(named: "search"), for: .normal)
//        self.contentSearchButton.addTarget(self, action: #selector(contentSearchButtonClicked), for: .touchUpInside)
//        self.topView.addSubview(self.contentSearchButton)
        
        self.contentScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.contentScrollView)
        
        self.contentStackView.axis = .vertical
        self.contentStackView.spacing = 10
        self.contentStackView.alignment = .fill
        self.contentStackView.distribution = .equalSpacing
        self.contentScrollView.addSubview(self.contentStackView)
        
        NSLayoutConstraint.activate([
            self.topView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 2),
            self.topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.topView.heightAnchor.constraint(equalToConstant: 50),
            
            self.topLineView.topAnchor.constraint(equalTo: self.topView.bottomAnchor, constant: 5),
            self.topLineView.leadingAnchor.constraint(equalTo: self.topView.leadingAnchor),
            self.topLineView.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor),
            self.topLineView.heightAnchor.constraint(equalToConstant: 1),
            
            self.latestButton.topAnchor.constraint(equalTo: self.topLineView.bottomAnchor, constant: 10),
            self.latestButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.latestButton.heightAnchor.constraint(equalToConstant: 20),
            self.latestButton.widthAnchor.constraint(equalToConstant: 80),
            
            self.accuracyButton.topAnchor.constraint(equalTo: self.topLineView.bottomAnchor, constant: 10),
            self.accuracyButton.leadingAnchor.constraint(equalTo: self.latestButton.trailingAnchor),
            self.accuracyButton.heightAnchor.constraint(equalToConstant: 20),
            self.accuracyButton.widthAnchor.constraint(equalToConstant: 110),
            
            self.uploadPostButton.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
            self.uploadPostButton.trailingAnchor.constraint(equalTo: self.topView.trailingAnchor, constant: -10),
            self.uploadPostButton.heightAnchor.constraint(equalTo: self.topView.heightAnchor, constant: -10),
            self.uploadPostButton.widthAnchor.constraint(equalToConstant: 100),
            
//            self.contentSearchButton.centerYAnchor.constraint(equalTo: self.topView.centerYAnchor),
//            self.contentSearchButton.trailingAnchor.constraint(equalTo: self.uploadPostButton.leadingAnchor, constant: -10),
//            self.contentSearchButton.heightAnchor.constraint(equalTo: self.uploadPostButton.heightAnchor),
//            self.contentSearchButton.widthAnchor.constraint(equalTo: self.contentSearchButton.heightAnchor),
            
            self.contentScrollView.topAnchor.constraint(equalTo: self.latestButton.bottomAnchor, constant: 10),
            self.contentScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.contentScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.contentScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.contentStackView.topAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.topAnchor, constant: 20),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.contentScrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            self.contentStackView.widthAnchor.constraint(equalTo: self.contentScrollView.widthAnchor),
        ])
        
        self.setPostsUI(completion: {
            loadingViewController.dismiss(animated: true)
        })
    }
    
    // TODO: 2024.09.02
    public func setPostsUI(keyword: String = "", completion: @escaping(() -> Void)) {
        
        let dispatchGroup = DispatchGroup()
        
        for view in self.contentStackView.arrangedSubviews {
            self.contentStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        DBManager.instance.getPostsInfo(sortOrder: self.sortingCriteria, keyword: keyword, completion: { posts in
            if posts == nil {
                return
            }
            
            for post in posts! {
                
                let postView = PostView(post: post)
                self.contentStackView.addArrangedSubview(postView)
                
                dispatchGroup.enter()
                
                DBManager.instance.downloadImageFromDB(imageURL: post.postImageUrl, completion: { postImage in
                    DispatchQueue.main.async {
                        postView.setPostImage(postImage: postImage!)
                        dispatchGroup.leave()
                    }
                })
            }
            
            dispatchGroup.notify(queue: .main, execute: {
                completion()
            })
        })
    }
    
    @objc func uploadPostButtonClicked(_ sender: UIButton) {
        let uploadPostViewController = UploadPostViewController()
        uploadPostViewController.modalTransitionStyle = .coverVertical
        uploadPostViewController.modalPresentationStyle = .overFullScreen
        self.present(uploadPostViewController, animated: true)
        
    }
    
    @objc func contentSearchButtonClicked(_ sender: UIButton) {
        
    }
    
    @objc func latestButtonClicked(_ sender: UIButton) {
        
        let loadingViewController = LoadingViewController()
        loadingViewController.modalTransitionStyle = .crossDissolve
        loadingViewController.modalPresentationStyle = .overFullScreen
        self.present(loadingViewController, animated: true)
        
        if self.sortingCriteria == .latest {
            AnimationHelper.instance.startViewSpringAnimation(view: self.latestButton, duration: 1, scale: 1.1)
            loadingViewController.dismiss(animated: true)
            return
        }
        self.sortingCriteria = .latest
        
        self.latestButton.titleLabel!.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.latestButton.setTitleColor(UIColor.systemOrange, for: .normal)
        
        self.accuracyButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 13)
        self.accuracyButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        AnimationHelper.instance.startViewSpringAnimation(view: self.latestButton, duration: 1, scale: 1.1)
        
        self.setPostsUI(completion: {
            print("sort success!")
            loadingViewController.dismiss(animated: true)
        })
    }
    
    @objc func accuracyButtonClicked(_ sender: UIButton) {
        
        
        self.sortingCriteria = .accuracy
        
        self.accuracyButton.titleLabel!.font = UIFont(name: "Pretendard-Bold", size: 15)
        self.accuracyButton.setTitleColor(UIColor.systemOrange, for: .normal)
        
        self.latestButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 13)
        self.latestButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        AnimationHelper.instance.startViewSpringAnimation(view: self.accuracyButton, duration: 1, scale: 1.1)
        
        let setSearchingKeywordViewController = SetSearchingKeywordViewController(searchButtonCommand: { keyword in
            
            let loadingViewController = LoadingViewController()
            loadingViewController.modalTransitionStyle = .crossDissolve
            loadingViewController.modalPresentationStyle = .overFullScreen
            self.present(loadingViewController, animated: true)
            
            self.setPostsUI(keyword: keyword, completion: {
                print("sort success!")
                loadingViewController.dismiss(animated: true)
            })
        }, exitButtonCommand: {
            let loadingViewController = LoadingViewController()
            loadingViewController.modalTransitionStyle = .crossDissolve
            loadingViewController.modalPresentationStyle = .overFullScreen
            self.present(loadingViewController, animated: true)
            
            self.sortingCriteria = .latest
            
            self.latestButton.titleLabel!.font = UIFont(name: "Pretendard-Bold", size: 15)
            self.latestButton.setTitleColor(UIColor.systemOrange, for: .normal)
            
            self.accuracyButton.titleLabel!.font = UIFont(name: "Pretendard-Medium", size: 13)
            self.accuracyButton.setTitleColor(UIColor.lightGray, for: .normal)
            
            AnimationHelper.instance.startViewSpringAnimation(view: self.latestButton, duration: 1, scale: 1.1)
            
            self.setPostsUI(completion: {
                print("sort success!")
                loadingViewController.dismiss(animated: true)
            })
        })
        
        setSearchingKeywordViewController.modalTransitionStyle = .crossDissolve
        setSearchingKeywordViewController.modalPresentationStyle = .overFullScreen
        
        self.present(setSearchingKeywordViewController, animated: true)
        
    }
    
}
