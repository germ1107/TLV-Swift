//
//  BaseResponse.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class BaseResponse {
    var tlv: Tlv = Tlv()
    
    required init(data: Data) {
        self.tlv.decode(from: data)
        self.decodeTlvPackage()
    }
    
    func decodeTlvPackage() {
        
    }
}
