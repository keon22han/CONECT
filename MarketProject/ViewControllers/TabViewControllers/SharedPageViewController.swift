//
//  SharedPageViewController.swift
//  MarketProject
//
//  Created by 한건희 on 8/21/24.
//

import UIKit

class SharedPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var PageViewControllerList = [UIViewController]()
    var uiSegmentedControl: UISegmentedControl?
    
    public func setViewControllers(viewControllers: [UIViewController]) {
        self.PageViewControllerList = viewControllers
        setupPageViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        createPageViewController()
        setupPageViewController()
    }
    
    // MARK: Pageview를 구성할 ViewController 생성
    func createPageViewController()
    {
        let firstViewController = SharingSeatsViewController() as UIViewController
        
        let secondViewController = SharingRefrigeratorViewController()
        secondViewController.view.backgroundColor = .clear
        
        self.PageViewControllerList.append(firstViewController)
        self.PageViewControllerList.append(secondViewController)
    }
    
    // MARK: PageViewController 설정
    func setupPageViewController()
    {
        // MARK: PageViewController DataSource 연결
        self.dataSource = self
        
        //첫번째로 위치할 ViewController 배치
        if let firstviewController = PageViewControllerList.first
        {
            setViewControllers([firstviewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }


    // MARK: 이전페이지에 위치할 ViewController return
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = PageViewControllerList.firstIndex(of: viewController) else
                {
                    return nil
                }
        
                let previousIndex = viewControllerIndex - 1
        
                guard previousIndex >= 0 else
                {
                    return PageViewControllerList.last
                }
        
                guard PageViewControllerList.count > previousIndex else
                {
                    return nil
                }
                return PageViewControllerList[previousIndex]
    }
    
    // MARK: 다음페이지에 위치할 ViewController return
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = PageViewControllerList.firstIndex(of: viewController) else
            {
                return nil
            }

        let nextIndex = viewControllerIndex + 1

        guard PageViewControllerList.count != nextIndex else
            {
                return PageViewControllerList.first
            }

        guard PageViewControllerList.count > nextIndex else
            {
                return nil
            }

        return PageViewControllerList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let segmentedControl = self.uiSegmentedControl else {
            return
        }
        
        if completed {
            if let currentVC = pageViewController.viewControllers?.first,
               let index = PageViewControllerList.firstIndex(of: currentVC) {
                segmentedControl.selectedSegmentIndex = index
            }
        }
    }

    func setSegmentedControl(uiSegmentedControl: UISegmentedControl) {
        self.uiSegmentedControl = uiSegmentedControl
    }
    
}
