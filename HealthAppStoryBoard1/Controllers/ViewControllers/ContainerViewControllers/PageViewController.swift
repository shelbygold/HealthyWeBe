//
//  DailTasksViewController.swift
//  HealthAppStoryBoard1
//
//  Created by shelby gold on 4/24/19.
//  Copyright © 2019 shelby gold. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [ self.newVc(viewController: "Page1"),
                 self.newVc(viewController: "Page2"),
                 self.newVc(viewController: "Page3"),
        self.newVc(viewController: "Page4")]
    }()
    
    var group: Group?
    
    var pageControl = UIPageControl()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
          
        }
        self.delegate = self
        configurePageControl()
        // Do any additional setup after loading the view.
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 50, width: UIScreen.main.bounds.width, height: 50))
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = .gray
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .gray
        self.view.addSubview(pageControl)
    }

    
    func newVc(viewController: String) -> UIViewController{
        switch viewController {
        case "Page1":
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? ChooseCategoryViewController
            newViewController?.group = group

            return newViewController ?? UIViewController()
        case "Page2":
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? GroupChatViewController
            newViewController?.group = group
            return newViewController ?? UIViewController()
        case "Page3":
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? GroupTaskTableViewController
            newViewController?.group = group
            return newViewController ?? UIViewController()
        case "Page4":
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as? LeaderBoardTableViewController
            newViewController?.group = group
            return newViewController ?? UIViewController()

        default:
            return UIViewController()
            
        }
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.firstIndex(of: pageContentViewController)!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            //            return orderedViewControllers.first
            return nil
        }
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Page1" {
            let destinVC = segue.destination as? CreateTaskViewController
            destinVC?.group = self.group
        }
    }
    
}
