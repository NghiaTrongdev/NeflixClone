//
//  Video.swift
//  CloneNeflix
//
//  Created by Trọng Nghĩa Nguyễn on 12/01/2024.
//

import Foundation

struct TrendingTitleResponse : Codable{
    var results :[Title]
}
struct Title : Codable{
    let id :Int
    let media_type :String?
    let origin_name :String?
    let origin_title :String?
    let poster_path :String?
    let vote_average :Double
    let overview : String?
    let vote_count :Int
    let realease_date :String?
}
