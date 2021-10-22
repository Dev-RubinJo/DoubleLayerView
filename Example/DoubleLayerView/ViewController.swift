//
//  ViewController.swift
//  DoubleLayerView
//
//  Created by Dev-RubinJo on 09/26/2021.
//  Copyright (c) 2021 Dev-RubinJo. All rights reserved.
//

import UIKit
import DoubleLayerView

class ViewController: UIViewController {

    @IBOutlet weak var doubleLayerView: DoubleLayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        doubleLayerView.cornerRadius = 20
    }
}

