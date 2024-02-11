//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим Жуин on 06.02.2024.
//

import UIKit

protocol IOnBoardingVC: AnyObject {
   func pushViewController()
}

class OnboardingViewController: UIViewController, IOnBoardingVC  {


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
        view.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        layout()
    }

    private func layout() {
        view.addSubview(mainView)
        mainView.loginVC = self
        mainView.frame = view.frame
    }

    func pushViewController() {
        let mainViewController = MainScreenViewController()
        UIView.animate(withDuration: 0.5) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainViewController)
        }
    }

}

