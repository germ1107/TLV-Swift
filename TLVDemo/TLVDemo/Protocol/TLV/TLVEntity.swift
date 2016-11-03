//
//  TLVEntity.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class TlvEntity {
    var length: UInt16?
    var value: Data?
    var tag: UInt8?
    
    func valueData() -> Data {
        //return value!
        guard value == nil else {
            return value!
        }
        
        return Data()
    }
    
}
