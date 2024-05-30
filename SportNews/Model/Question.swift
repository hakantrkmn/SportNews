//
//  Question.swift
//  SportNews
//
//  Created by Hakan Türkmen on 26.05.2024.
//

import Foundation


struct Question : Decodable
{
    let question : String
    let options : [String]
    let correctAnswer : Int
    let image : String
}
