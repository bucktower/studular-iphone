//
//  MasterViewController.swift
//  studular-iphone
//
//  Created by Buck Tower on 4/1/15.
//  Copyright (c) 2015 Buck Tower. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects: Array<Assignment> = []
    var sketchbook: NSManagedObjectContext?


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        sketchbook = appDelegate.managedObjectContext
        
        // save the sketchbook
        updateSketchbookToDisk()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        if let sktchbk = sketchbook {
            // create an empty song
            let theSongEntity = NSEntityDescription.entityForName("Assignment", inManagedObjectContext: sktchbk)
            let assignment = Assignment(entity: theSongEntity!, insertIntoManagedObjectContext: sktchbk)
            
            // give the song some starting values
            assignment.inClass = "Class"
            assignment.title = "Title"
            assignment.desc = "Description"
            //assignment.dueDate = "1/1/15"
            
            // put the song into the song list
            objects.insert(assignment, atIndex: 0)
            
            // insert a row at the top of the table
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            // save the sketchbook
            updateSketchbookToDisk()
        }
    }
    
    // MARK: - CoreData
    func updateSketchbookToDisk()
    {
        if let sktchbk = sketchbook
        {
            var error: NSError?
            let successfullySaved = sktchbk.save(&error)
            if successfullySaved == false
            {    println("Could not save \(error), \(error?.userInfo)")
            }
        }
        else
        {
            println("Could not find managedContext.")
        }
    }
    
    func updateDiskToSketchbook()
    {
        let fetchRequest = NSFetchRequest(entityName: "Assignment")// replace Movie with your data name.
        
        // submit your request and store the result in the optional "fetchedResults"
        if let sktchbk = sketchbook // Period C - use "mySketchbook"
        {
            println("Found context")
            var error: NSError?
            let fetchedResults = sktchbk.executeFetchRequest(fetchRequest, error: &error) as [Assignment]? // replace "Movie" with your data entity name.
            
            // if the optional is filled, store the contents in "objects."
            if let results = fetchedResults
            {
                objects = results
            }
            else // otherwise, print an error message and leave the objects list alone.
            {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
        }
        else
        {
            println("Could not find managedObjectContext 'sketchbook.'")
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row] as Assignment
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func saveToMasterView(sender: UIStoryboardSegue) {
        tableView.reloadData()
        updateSketchbookToDisk()
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        println("Getting object #\(indexPath.row) from list with \(objects.count) items.")
        let object:Assignment = objects[indexPath.row]
        print("got here.")
        //        {
            println(object.cellText)
//        }
        //else
//        {
//            print("object was nil!")
//        }
       // cell.textLabel!.text = object.cellText
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

