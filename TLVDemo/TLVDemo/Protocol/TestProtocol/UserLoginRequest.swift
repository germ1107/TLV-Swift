//
//  UserLoginRequest.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class UserLoginRequest : BaseRequest {
    var userId: UInt32 = 0
    var password: String = ""
    var nickname: String = ""
    
    override func encodeTlvPackage() {
        self.tlv.pushUInt32(value: self.userId, tag: 1)
        self.tlv.pushString(value: self.password, tag: 2)
        self.tlv.pushString(value: self.nickname, tag: 3)
    }
}
