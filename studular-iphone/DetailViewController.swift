//
//  DetailViewController.swift
//  studular-iphone
//
//  Created by Buck Tower on 4/1/15.
//  Copyright (c) 2015 Buck Tower. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var ClassSegmentedControl: UISegmentedControl!
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    var detailItem: Assignment? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Assignment = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
            
            if let inClass = ClassSegmentedControl {
                // WIP - select active segment
                //ClassSegmentedControl.active = detail.inClass
            }
            if let title = TitleTextField {
                TitleTextField.text = detail.title
            }
            if let desc = DescriptionTextView {
                DescriptionTextView.text = detail.desc
            }
            if let dueDate = DatePicker {
                // WIP - select active date
                //DatePicker.active = detail.dueDate
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detail:Assignment = detailItem {
            if let inClassSeg = ClassSegmentedControl {
                //detail.inClass = ClassSegmentedControl.selectedSegmentIndex
            }
            if let titleFld = TitleTextField {
                detail.title = TitleTextField.text
            }
            if let descFld = DescriptionTextView {
                detail.desc = DescriptionTextView.text
            }
            if let dueDatePkr = DatePicker {
                //detail.dueDate = Date(DatePicker.date)
            }
            println(detail.description)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // WIP - UNCOMMENT WHEN WORKING TEST
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

