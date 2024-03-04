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
    var coreDataModelService: CoreDataModelService {get set}
    func createViewControllerWithModel(model: MainForecastsModels)
    func initialFetch()
    func updateViewControllers()
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
    }

    func createViewControllerWithModel(model: MainForecastsModels) {

        let forecastModelService = ForecastModelService(coreDataModel: model)
       // forecastModelService.updateCurrentForecastByDate()
        guard let forecastArray = forecastModelService.forecastModel else { return }
        if let forecast = forecastArray.first {
            let hourModelService = HoursModelService(coreDataModel: forecast)
            let hoursArray = hourModelService.hoursArray

            let tableViewDataSource = DataSourceForMainScreen()
            let collectionViewDataSource = DataSourceForMainCollectionCell()
            tableViewDataSource.updateData(data: forecastArray)
            collectionViewDataSource.updateData(data: hoursArray)

            let mainScreenVC = MainScreenViewController(coreDataModelService: coreDataModelService, forecastsModel: forecast, hoursModels: hoursArray, forecastModelsArray: forecastArray, mainModel: model, tableViewDataSource: tableViewDataSource, collectionViewDataSource: collectionViewDataSource)
            mainScreenVC.updateNavigationItems(model: model)
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
        //    forecastModelService.updateCurrentForecastByDate()
            guard let forecastArray = forecastModelService.forecastModel else { return }
            if let forecast = forecastArray.first {
                let hourModelService = HoursModelService(coreDataModel: forecast)
                let hoursArray = hourModelService.hoursArray

                let tableViewDataSource = DataSourceForMainScreen()
                let collectionViewDataSource = DataSourceForMainCollectionCell()
                tableViewDataSource.updateData(data: forecastArray)
                collectionViewDataSource.updateData(data: hoursArray)

                print(tableViewDataSource.dataSource.count)
                print(collectionViewDataSource.dataSource.count)

                let mainScreenVC = MainScreenViewController(coreDataModelService: coreDataModelService, forecastsModel: forecast, hoursModels: hoursArray, forecastModelsArray: forecastArray, mainModel: model, tableViewDataSource: tableViewDataSource, collectionViewDataSource: collectionViewDataSource)
                
                self.viewControllersArray?.append(mainScreenVC)
                guard let model = coreDataModelService.modelArray?.first else { return  }
                mainScreenVC.updateNavigationItems(model: model)
                self.navigationItem.title = mainScreenVC.navigationItem.title
                self.navigationItem.rightBarButtonItem = mainScreenVC.navigationItem.rightBarButtonItem
                self.navigationItem.leftBarButtonItem = mainScreenVC.navigationItem.leftBarButtonItem
            }
        }
        updateViewControllers()
    }

    func updateViewControllers() {
        if let viewControllersArray = viewControllersArray {
            setViewControllers([viewControllersArray.first!], direction: .forward, animated: true)
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
