//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit

class OnboardingViewController: UIViewController {

    private let mainView: OnboardingView


    init(mainView: OnboardingView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 88/255, blue: 192/255, alpha: 1)
        layout()
    }

    private func layout() {
        view.addSubview(mainView)
        mainView.accessGeoButton.addTarget(self, action: #selector(accessGeoButtonTapped(_:)), for: .touchUpInside)
        mainView.frame = view.frame
    }

    @objc func accessGeoButtonTapped(_ sender: UIButton) {
        let mainViewController = MainScreenViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        UIView.animate(withDuration: 0.5) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navigationController)
        }
    }

}

