//
//  NumbersEntity+CoreDataProperties.swift
//  whatsapp-me
//
//  Created by arham on 05/12/23.
//
//

import Foundation
import CoreData


extension NumbersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NumbersEntity> {
        return NSFetchRequest<NumbersEntity>(entityName: "NumbersEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var number: String?

}

extension NumbersEntity : Identifiable {

}
