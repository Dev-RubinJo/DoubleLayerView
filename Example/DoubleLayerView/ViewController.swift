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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapAnimateButton(_ sender: Any) {
        doubleLayerView.changeProperty()
    }
}

