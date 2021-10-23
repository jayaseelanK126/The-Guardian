//
//  AppConfig.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation
import UIKit

struct AppConfig
{
    static var isiPad: Bool = (UIDevice.current.userInterfaceIdiom == .pad ? true : false)
    static var timeStampFormat : String = "yyyy-MM-dd'T'HH:mm:ssZ"
    static var baseURL = "https://content.guardianapis.com/search?"
    static var APIKey = "0e56c9de-e16f-4606-9f6f-53dbf7c1af97"

}


//https://content.guardianapis.com/search?q=12%20years%20a%20slave&format=json&tag=film/film,tone/reviews&from-date=2010-01-01&show-tags=contributor&show-fields=starRating,headline,thumbnail,short-url&order-by=relevance&api-key=test




//https://content.guardianapis.com/search?q=Afghanistan&show-fields=starRating,headline,thumbnail,body,short-url&order-by=relevance&api-key=0e56c9de-e16f-4606-9f6f-53dbf7c1af97
