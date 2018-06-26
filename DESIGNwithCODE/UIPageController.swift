//
//  PageViewController.swift
//  UIPageControl Sample
//
//  Created by Francis Jemuel Bergonia on 26/06/2018.
//  Copyright © 2018 Francis Jemuel Bergonia. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(color: "Green"),
                self.newColoredViewController(color: "Red"),
                self.newColoredViewController(color: "Blue")]
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: "backgroundImage")
        backgroundImageView.contentMode = .scaleAspectFit
        return backgroundImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.insertSubview(backgroundImageView, at: 0)

        dataSource = self
        setupLayout()
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        var topSafeArea = CGFloat()
//        var bottomSafeArea = CGFloat()
        
        if #available(iOS 11.0, *) {
//            topSafeArea = view.safeAreaInsets.top
//            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
//            topSafeArea = topLayoutGuide.length
//            bottomSafeArea = bottomLayoutGuide.length
            //setupLayout()
        }
        
        // safe area values are now available to use
        
    }
    
    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.backgroundColor = .blue
        //view.addSubview(topImageContainerView)
        view.insertSubview(topImageContainerView, at: 0)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
//        topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        topImageContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        
        topImageContainerView.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
//        backgroundImageView.topAnchor.constraint(equalTo: topImageContainerView.topAnchor).isActive = true
//
//        backgroundImageView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor).isActive = true
//        backgroundImageView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor).isActive = true
//
//        backgroundImageView.bottomAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
//        backgroundImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 1).isActive = true
    }
    
    
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }

    

}
