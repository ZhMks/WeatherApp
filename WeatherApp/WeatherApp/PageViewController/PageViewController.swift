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
    var coreDataModelService: MainForecastModelService {get set}
    func createViewControllerWithModel(model: MainForecastsModels)
    func initialFetch()
    func updateViewControllers()
    var viewControllersArray: [MainScreenViewController]? { get set }
}

final class PageViewController: UIPageViewController, iPageViewController {

    var coreDataModelService: MainForecastModelService

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0,y: 75,width: UIScreen.main.bounds.width, height: 50))
        pageControl.currentPage = 0
        pageControl.tintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.backgroundColor = .clear
        return pageControl
    }()

    var viewControllersArray: [MainScreenViewController]?
    private let geoDataService: GeoDataModelService


    init(coreDataModelService: MainForecastModelService, geoDataService: GeoDataModelService) {
        self.coreDataModelService = coreDataModelService
        self.geoDataService = geoDataService
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        view.backgroundColor = .systemBackground
        viewControllersArray = []
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.delegate = self
        self.dataSource = self
        view.addSubview(pageControl)
    }

    func createViewControllerWithModel(model: MainForecastsModels) {

        let forecastModelService = ForecastModelService(coreDataModel: model)

        guard let forecastArray = forecastModelService.forecastModel else { return }

        if let forecast = forecastArray.first {
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            let tableViewDataSource = DataSourceForMainScreen()
            let collectionViewDataSource = DataSourceForMainCollectionCell()
            tableViewDataSource.updateData(data: forecastArray)
            collectionViewDataSource.updateData(data: hoursArray)

            let mainScreenVC = MainScreenViewController(coreDataModelService: coreDataModelService, forecastsModel: forecast, hoursModels: hoursArray, forecastModelsArray: forecastArray, mainModel: model, tableViewDataSource: tableViewDataSource, collectionViewDataSource: collectionViewDataSource, geoDataService: geoDataService)
            mainScreenVC.updateNavigationItems(model: model)
            mainScreenVC.mainPageViewController = self
            self.viewControllersArray?.append(mainScreenVC)
            self.navigationItem.title = mainScreenVC.navigationItem.title
            self.navigationItem.leftBarButtonItem = mainScreenVC.navigationItem.leftBarButtonItem
            self.navigationItem.rightBarButtonItem = mainScreenVC.navigationItem.rightBarButtonItem
        }
        updateViewControllers()
    }

    func initialFetch() {
        guard let modelArray = coreDataModelService.modelArray else { return }

        for model in modelArray {

            let forecastModelService = ForecastModelService(coreDataModel: model)

            guard let forecastArray = forecastModelService.forecastModel else { return }
            if let forecast = forecastArray.first {
                let hourModelService = HoursModelService(coreDataModel: forecast)
                let hoursArray = hourModelService.hoursArray

                let tableViewDataSource = DataSourceForMainScreen()
                let collectionViewDataSource = DataSourceForMainCollectionCell()
                tableViewDataSource.updateData(data: forecastArray)
                collectionViewDataSource.updateData(data: hoursArray)

                let mainScreenVC = MainScreenViewController(coreDataModelService: coreDataModelService, forecastsModel: forecast, hoursModels: hoursArray, forecastModelsArray: forecastArray, mainModel: model, tableViewDataSource: tableViewDataSource, collectionViewDataSource: collectionViewDataSource, geoDataService: geoDataService)

                self.viewControllersArray?.append(mainScreenVC)
                mainScreenVC.mainPageViewController = self
                guard let model = coreDataModelService.modelArray?.first else { return  }
                mainScreenVC.updateNavigationItems(model: model)
                self.navigationItem.title = mainScreenVC.navigationItem.title
                self.navigationItem.rightBarButtonItem = mainScreenVC.navigationItem.rightBarButtonItem
                self.navigationItem.leftBarButtonItem = mainScreenVC.navigationItem.leftBarButtonItem
                if let viewControllersArray = viewControllersArray {
                    setViewControllers([viewControllersArray.first!], direction: .forward, animated: true)
                    pageControl.numberOfPages = viewControllersArray.count
                }
            }
        }
    }

    func updateViewControllers() {
        self.dataSource = nil
        self.dataSource = self
        if let viewControllersArray = viewControllersArray {
            setViewControllers([viewControllersArray.last!], direction: .forward, animated: true)
            pageControl.numberOfPages = viewControllersArray.count
        }
    }
}


    extension PageViewController: UIPageViewControllerDataSource {

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewController = viewController as? MainScreenViewController else { return nil }
            if let index = viewControllersArray?.firstIndex(of: viewController) {
                if index > 0 {
                    guard let model = coreDataModelService.modelArray?[index] else { return UIViewController() }
                    viewController.updateNavigationItems(model: model)
                    self.navigationItem.title = viewController.navigationItem.title
                    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
                    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
                    pageControl.currentPage = index
                    return viewControllersArray![index - 1]
                }
            }
            guard let model = coreDataModelService.modelArray?.first else { return UIViewController() }
            viewController.updateNavigationItems(model: model)
            self.navigationItem.title = viewController.navigationItem.title
            self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
            self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
            return nil
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewController = viewController as? MainScreenViewController else { return nil }
            if let index = viewControllersArray?.firstIndex(of: viewController) {
                if index < viewControllersArray!.count - 1 {

                    guard let model = coreDataModelService.modelArray?[index] else { return UIViewController() }
                    viewController.updateNavigationItems(model: model)
                    self.navigationItem.title = viewController.navigationItem.title
                    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
                    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
                    pageControl.currentPage = index
                    return viewControllersArray![index + 1]
                }
            }
            guard let model = coreDataModelService.modelArray?.last else { return UIViewController() }
            viewController.updateNavigationItems(model: model)
            self.navigationItem.title = viewController.navigationItem.title
            self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
            self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
            return nil
        }

        func presentationCount(for pageViewController: UIPageViewController) -> Int {
            if let viewControllersArray = viewControllersArray {
                return viewControllersArray.count
            }
            return 0
        }

    }

extension PageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return }
            DispatchQueue.main.async { [weak self] in
                self?.dataSource = nil
                self?.dataSource = self
            }
    }

}
