//
//  String+Ext.swift
//  SportNews
//
//  Created by Hakan Türkmen on 24.04.2024.
//

import Foundation

extension String
{
    func convertFormattedDate() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: self)

        // Convert Date to String
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: date!)
    }
}
