//
//  Assignment.swift
//  studular-iphone
//
//  Created by Buck Tower on 4/7/15.
//  Copyright (c) 2015 Buck Tower. All rights reserved.
//

import Foundation
import CoreData

class Assignment: NSManagedObject {
    
    @NSManaged var title: String
    @NSManaged var desc: String
    @NSManaged var inClass: String
    @NSManaged var dueDate: Int16
    
    var cellText:String {
        return "\(inClass): \(title)"
    }
    
}