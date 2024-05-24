//
//  View+Ext.swift
//  SportNews
//
//  Created by Hakan Türkmen on 24.04.2024.
//

import UIKit

extension UIView
{
    func addSubiews(views : UIView...)
    {
        for view in views
        {
            addSubview(view)
        }
    }
    
    func screenshot() -> UIImage {
        let size =  CGSize(width: bounds.size.width, height: bounds.size.height )
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
          drawHierarchy(in: CGRect(origin: .zero, size: size
                                  ), afterScreenUpdates: true)
        }
      }
}


enum ImageError: Error {
    case invalidData
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
