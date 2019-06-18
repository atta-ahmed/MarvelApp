//
//  ImageSliderViewController.swift
//  MarvelAPP
//
//  Created by Atta Amed on 6/18/19.
//  Copyright © 2019 Atta Amed. All rights reserved.
//

import UIKit

class ImageSliderViewController: UIPageViewController {
   
    var pageControl = UIPageControl()
    var imageSourceArray = [Details]()
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.delegate = self
        configurePageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        makeNavigationTransparent()
        if let viewController = viewPhotoController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resetNavigationTransparency()
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 60,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = imageSourceArray.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
}

extension ImageSliderViewController: UIPageViewControllerDataSource , UIPageViewControllerDelegate {
    
    func viewPhotoController(_ index: Int) -> PhotoViewController? {
        if let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController {
            page.photoPath = imageSourceArray[index].thumImage?.fullPath()
            page.photoName = imageSourceArray[index].title
            page.photoIndex = index
            return page
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoViewController,
            let index = viewController.photoIndex,
            index > 0 {
            return viewPhotoController(index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PhotoViewController,
            let index = viewController.photoIndex,
            (index + 1) < imageSourceArray.count {
            return viewPhotoController(index + 1)
        }
        return nil
    }
    
    // MARK: Delegate functions
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0] as! PhotoViewController
        self.pageControl.currentPage = pageContentViewController.photoIndex
    }
}

