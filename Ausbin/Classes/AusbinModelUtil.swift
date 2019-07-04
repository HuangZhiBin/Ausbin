//
//  AusbinModelUtil.swift
//
//  Created by 2018年 BinHuang on 2019/4/22.
//

import UIKit

class AusbinModelUtil: NSObject {
    
    static func isModel(typeName: String) -> Bool{
        let arr : [String] = [
            "id",
            "Bool",
            "NSArray",
            "Double",
            "NSString",
            "Float",
            "Long",
            "Short",
            "Struct",
            "Enum",
            "NSObject",
            "NSDate",
            "Int",
            "Int8",
            "Int16",
            "Int32",
            "Int64",
            "UInt",
            "UInt16",
            "UInt32",
            "UInt64",
            "Bool",
            "Double",
            "Float",
            "Decimal"];
        if(arr.contains(typeName)){
            return false;
        }
        return true;
    }

}
