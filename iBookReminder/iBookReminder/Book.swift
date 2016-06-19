//
//  Book.swift
//  iBookReminder
//
//  Created by Manish on 02/11/15.
//  Copyright (c) 2015 ifconit. All rights reserved.
//

import Foundation
import CoreData

@objc(Book)
class Book: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var read: NSNumber
    @NSManaged var rating: NSNumber
    @NSManaged var purchase: NSNumber
    @NSManaged var isbn_no: String
    @NSManaged var id: NSNumber
    @NSManaged var fav: NSNumber
    @NSManaged var desption: String
    @NSManaged var bookimg: NSData
    @NSManaged var author: String

}
