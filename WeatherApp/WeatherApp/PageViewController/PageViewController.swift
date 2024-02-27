//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 26.02.2024.
//

import Foundation
import UIKit
import SnapKit

protocol iPageViewController: AnyObject {
    func addToPageViewControllerWith(name: String)
    var coreDataModelService: CoreDataModelService {get set}
}

final class PageViewController: UIPageViewController, iPageViewController {
    
    var coreDataModelService: CoreDataModelService

    private(set) var viewControllersArray: [MainScreenViewController]?


    init(coreDataModelService: CoreDataModelService) {
        self.coreDataModelService = coreDataModelService
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        view.backgroundColor = .systemBackground
        viewControllersArray = []
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let scrollView = view.subviews.filter({ $0 is UIScrollView }).first,
           let pageControl = view.subviews.filter({ $0 is UIPageControl }).first {
            scrollView.frame = view.bounds
            view.bringSubviewToFront(pageControl)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.delegate = self
        self.dataSource = self
        let pageControle = UIPageControl.appearance(whenContainedInInstancesOf: [PageViewController.self])
        pageControle.currentPageIndicatorTintColor = .black
        pageControle.pageIndicatorTintColor = .gray
    }

    func initialCreation() {

        let mainForecastModelsArray = coreDataModelService.modelArray

        if let mainForecastModelsArray {
            if let _ = self.viewControllersArray {
                for model in mainForecastModelsArray {

                    let forecastModelService = ForecastModelService(coreDataModel: model)

                    let forecastArray = forecastModelService.forecastModel

                    for forecast in forecastArray! {
                        let hourModelService = HoursModelService(coreDataModel: forecast)
                        let hoursArray = hourModelService.hoursArray
                        let mainScreenViewController = MainScreenViewController(coreDataModelService: coreDataModelService, forecastsModel: forecast, hoursModels: hoursArray, forecastModelsArray: forecastArray!, mainModel: model)
                        mainScreenViewController.mainPageViewController = self
                        self.viewControllersArray?.append(mainScreenViewController)
                        self.navigationItem.title = mainScreenViewController.navigationItem.title
                        self.navigationItem.leftBarButtonItem = mainScreenViewController.navigationItem.leftBarButtonItem
                        self.navigationItem.rightBarButtonItem = mainScreenViewController.navigationItem.rightBarButtonItem
                        setViewControllers([self.viewControllersArray![0]], direction: .forward, animated: true)
                    }
                }
            }
        }
    }

    func addToPageViewControllerWith(name: String) {
        let mainForecastModelsArray = coreDataModelService.modelArray

        let components = name.components(separatedBy: "/")

        let formattedString = "\(components[1]), \(components[0])"

        guard let firstElement = mainForecastModelsArray?.first(where: { $0.name! == formattedString }) else { return }

       // let forecastModelService = ForecastModelService(coreDataModel: firstElement)

    }

}

extension PageViewController: UIPageViewControllerDataSource {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        guard let viewControllersArray = viewControllersArray else { return 0 }
        return viewControllersArray.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainScreenViewController else { return nil }
        if let index = viewControllersArray?.firstIndex(of: viewController) {
            if index > 0 {
                return viewControllersArray![index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MainScreenViewController else { return nil }
        if let index = viewControllersArray?.firstIndex(of: viewController) {
            if index < viewControllersArray!.count - 1 {
                return viewControllersArray![index + 1]
            }
        }
        return nil
    }


}

extension PageViewController: UIPageViewControllerDelegate {


}
