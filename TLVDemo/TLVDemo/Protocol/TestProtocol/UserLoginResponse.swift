//
//  UserLoginResponse.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class UserLoginResponse : BaseResponse {
    var userId: UInt32 = 0
    var password: String = ""
    var nickname: String = ""
    
    override func decodeTlvPackage() {
        self.userId = self.tlv.getUInt32(tag: 1)
        self.password = self.tlv.getString(tag: 2)
        self.nickname = self.tlv.getString(tag: 3)
    }
}
