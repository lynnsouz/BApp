//
//  ListStatementFactory.swift
//  BankApp
//
//  Created by Lynneker Souza on 05/12/20.
//  Copyright © 2020 Lynneker Souza. All rights reserved.
//

import Foundation
import UIKit

@objc class ListStatementFactory: NSObject {
    func newListStatementViewController() -> UIViewController {
        let vc = ListStatementViewController()
        let interactor = ListStatementInteractor()
        let presenter = ListStatementPresenter()
        let router = ListStatementRouter()
        let worker = ListStatementWorker()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = vc
        router.dataStore = interactor
        
        return vc
    }
}
