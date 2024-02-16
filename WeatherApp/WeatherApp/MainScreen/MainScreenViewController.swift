//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit
import SnapKit

protocol IMainScreenController: AnyObject {
    func pushTwentyFourVc()
    func pushDayNightVc()
}

class MainScreenViewController: UIViewController, IMainScreenController {

    private let coreDataModelService: CoreDataModelService

    private let networkService: INetworkService = NetworkService()

    private let mainScreenView = MainScreenView()

    init(coreDataModelService: CoreDataModelService) {
        self.coreDataModelService = coreDataModelService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        networkService.fetchData(lat: 55.75396, lon: 37.620393) { result in
            switch result {
            case .success(let fetchedData):
                self.coreDataModelService.saveModelToCoreData(networkModel: fetchedData)
            case .failure(let failure):
                print(failure.description)
            }
        }
    }

    private func layout() {
        view.addSubview(mainScreenView)
        updateViewControlelr()
        mainScreenView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide

        mainScreenView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeArea)
        }
    }

    private func updateViewControlelr() {
        mainScreenView.mainScreenVC = self

        guard let modelArray = coreDataModelService.modelArray else { return }
        mainScreenView.dataModelArray = modelArray
        guard let name = coreDataModelService.modelArray?.first?.name else { return }
        navigationItem.title = name

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Burger"), style: .plain, target: self, action: #selector(burgerButtonTapped(_:)))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Landmark"), style: .plain, target: self, action: #selector(rightButtonTapped(_:)))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    func pushTwentyFourVc() {
        let request = MainForecastsModels.fetchRequest()
        do {
            let array = try CoreDataService.shared.managedContext.fetch(request)
            let twentyFourVC = DetailTwentyFourViewController(dataModel: array)
            navigationController?.pushViewController(twentyFourVC, animated: true)
        } catch {

        }
    }

    @objc private func burgerButtonTapped(_ sender: UIBarButtonItem) {
        let settingsVC = SettingsViewController()
        navigationController?.present(settingsVC, animated: true)
    }

    func pushDayNightVc() {
        let detailDayVC = DetailDayViewController()
        navigationController?.pushViewController(detailDayVC, animated: true)
    }

    @objc private func rightButtonTapped(_ sender: UIBarButtonItem) {}
}
