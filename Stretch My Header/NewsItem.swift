//
//  NewsItem.swift
//  Stretch My Header
//
//  Created by Cody Zazulak on 2015-08-04.
//  Copyright (c) 2015 Cody Zazulak. All rights reserved.
//

import UIKit

class NewsItem: NSObject {
    
    var category:String
    var headline:String
    
    init(aCategory:String, aHeadline:String){
        category = aCategory
        headline = aHeadline
    }
   
}
