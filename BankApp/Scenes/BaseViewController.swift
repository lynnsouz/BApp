//
//  BaseViewController.swift
//  BankApp
//
//  Created by Lynneker Souza on 05/12/20.
//  Copyright © 2020 Lynneker Souza. All rights reserved.
//

import UIKit

@objc protocol ConfiguratorProtocol {
    func config(_ viewController: UIViewController)
}

@objc class BaseViewController: UIViewController {
    var configurator: ConfiguratorProtocol?
    
    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }
    
    @objc init(configurator: ConfiguratorProtocol) {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        self.configurator = configurator
        self.configurator?.config(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
