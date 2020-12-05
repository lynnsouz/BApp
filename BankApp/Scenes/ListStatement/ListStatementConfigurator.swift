//
//  ListStatementConfigurator.swift
//  BankApp
//
//  Created by Lynneker Souza on 05/12/20.
//  Copyright © 2020 Lynneker Souza. All rights reserved.
//

import UIKit

class ListStatementConfigurator: ConfiguratorProtocol {
    // MARK: Configuration
    func config(_ viewController: UIViewController) {
        guard let vc = viewController as? ListStatementViewController else {
            return
        }
        
        let interactor = ListStatementInteractor()
        let presenter = ListStatementPresenter()
        let router = ListStatementRouter()
        let worker = ListStatementWorker()

        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
    }
}


