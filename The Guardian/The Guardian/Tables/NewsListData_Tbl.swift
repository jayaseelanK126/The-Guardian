//
//  NewsListData_Tbl.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation
import RealmSwift

//MATK:- Realm table 
class NewsListData_Tbl: Object
{
    @objc dynamic var MobilePrimaryId: Int = 1
    @objc dynamic var id: String = ""
    @objc dynamic var publicationDate: String = ""
    @objc dynamic var newsTitle: String = ""
    @objc dynamic var newsThumbnail: String = ""
    @objc dynamic var newsBody: String = ""
    @objc dynamic var newsURL: String = ""
    @objc dynamic var thumbNailImgData: Data?

        
    
    override class func primaryKey() -> String?
    {
        return "MobilePrimaryId"
    }
    
    func incrementMobilePrimaryId() -> Int
    {
        let realm = try! Realm()
        return (realm.objects(NewsListData_Tbl.self).max(ofProperty: "MobilePrimaryId") as Int? ?? 0) + 1
    }
}

