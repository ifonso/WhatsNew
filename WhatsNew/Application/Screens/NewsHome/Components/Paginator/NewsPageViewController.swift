//
//  NewsPageViewController.swift
//  WhatsNew
//
//  Created by Afonso Lucas on 15/05/24.
//

import UIKit

final class NewsPageViewController: UIPageViewController {
    // MARK: - State
    weak var pageChangeDelegate: NewsPageChangeDelegate?
    
    private var currentIndex: Int
    private let viewControllersList: [UIViewController]
    
    // MARK: - Lifecycle & Initializers
    init(viewControllersList: [UIViewController]) {
        self.viewControllersList = viewControllersList
        self.currentIndex = 0
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("cant initialize this class with storyboard")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.loadViewControllers(at: 0)
    }
    
    // MARK: - Utility
    func loadViewControllers(at index: Int) {
        guard index >= 0 && index < viewControllersList.count else { return }
        
        self.setViewControllers([viewControllersList[index]],
                                direction: currentIndex > index ? .reverse : .forward,
                                animated: true)
        
        self.currentIndex = index
    }
}

// MARK: - PageViewController Data Source
extension NewsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.lastIndex(of: viewController),
              index - 1 >= 0
        else { return nil }
        
        return viewControllersList[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, 
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersList.lastIndex(of: viewController),
              index + 1 < viewControllersList.count
        else { return nil }
        
        return viewControllersList[index + 1]
    }
}

// MARK: - PageViewController Delegate
extension NewsPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, 
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed,
              let currentViewController = pageViewController.viewControllers?.first,
              let index = viewControllersList.firstIndex(of: currentViewController)
        else { return }
        
        currentIndex = index
        pageChangeDelegate?.pageChange(to: index)
    }
}
