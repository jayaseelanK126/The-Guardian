//
//  NewsData.swift
//  The Guardian
//
//  Created by Pyramid on 23/10/21.
//

import Foundation

struct NewsData: Codable
{
    let response: Response
}
struct Response: Codable
{
    let status: String
    let results: [Results]
}
struct Results: Codable
{
    let id :String
    let webPublicationDate: String
    let webTitle: String
    let webUrl:String
    let fields: Fields
}

struct Fields: Codable {
    let body: String
    let thumbnail: String
}
