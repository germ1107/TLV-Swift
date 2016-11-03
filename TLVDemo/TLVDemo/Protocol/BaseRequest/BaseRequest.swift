//
//  BaseRequest.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class BaseRequest {
    var tlv: Tlv = Tlv()
    var moduleId: UInt32 = 0
    var messageCode: UInt16 = 0
    
    func encodeTlvPackage() {
        //子类重写该方法
    }
    
    func packageData() -> Data {
        self.encodeTlvPackage()
        return self.tlv.encode()
    }
}
