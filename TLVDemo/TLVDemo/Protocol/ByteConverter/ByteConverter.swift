//
//  ByteConverter.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class ByteConverter {
    class func byteFromUint8(value: UInt8) -> Data {
        var byteArray: [UInt8] = [0]
        byteArray[0] = value & 0xff
        return Data(bytes: byteArray)
    }
    
    class func byteFromUint16(value: UInt16) -> Data {
        var byteArray: [UInt8] = [0, 0]
        byteArray[0] = UInt8(value >> 8 & 0xff)
        byteArray[1] = UInt8(value & 0xff)
        return Data(bytes: byteArray)
    }
    
    class func byteFromUint32(value: UInt32) -> Data {
        var byteArray: [UInt8] = [0, 0, 0, 0]
        
        byteArray[3] = UInt8(value & 0xff)
        byteArray[2] = UInt8(value >> 8 & 0xff)
        byteArray[1] = UInt8(value >> 16 & 0xff)
        byteArray[0] = UInt8(value >> 24 & 0xff)
        
        return Data(bytes: byteArray)
        
        /*var bigEndian = value.bigEndian
         let count = MemoryLayout<UInt32>.size
         let bytePtr = withUnsafePointer(to: &bigEndian) {
         $0.withMemoryRebound(to: UInt8.self, capacity: count) {
         UnsafeBufferPointer(start: $0, count: count)
         }
         }
         let xxArray = Array(bytePtr)
         print(xxArray)
         return Data(bytes: xxArray)*/
    }
    
    class func byteFromString(value: String) -> Data {
        var tempString = String(value)
        tempString?.append("\0")
        let data: Data = value.data(using: .utf8)!
        return data
    }
    
    class func uint8FromData(data: Data) -> UInt8 {
        var byteArray: [UInt8] = [0]
        let bytePtr = UnsafeMutableBufferPointer<UInt8>(start: &byteArray, count: byteArray.count)
        _ = data.copyBytes(to: bytePtr)
        
        return UInt8(bytePtr[0]) & 0xff
    }
    
    class func uint16FromData(data: Data) -> UInt16 {
        var byteArray: [UInt8] = [0, 0]
        let bytePtr = UnsafeMutableBufferPointer<UInt8>(start: &byteArray, count: byteArray.count)
        _ = data.copyBytes(to: bytePtr)
        
        return (UInt16((bytePtr[1] & 0xff)) << 0) + (UInt16((bytePtr[0] & 0xff)) << 8)
    }
    
    class func uint32FromData(data: Data) -> UInt32 {
        var byteArray: [UInt8] = [0, 0, 0, 0]
        let bytePtr = UnsafeMutableBufferPointer<UInt8>(start: &byteArray, count: byteArray.count)
        _ = data.copyBytes(to: bytePtr)
        
        var result: UInt32 = (UInt32((bytePtr[3] & 0xff)) << 0)
        result += (UInt32((bytePtr[2] & 0xff)) << 8)
        result += (UInt32((bytePtr[1] & 0xff)) << 16)
        result += (UInt32((bytePtr[0] & 0xff)) << 24)
        
        return result
    }
    
    class func stringFromData(data: Data) -> String {
        guard data.count == 0 else {
            return String(data: data, encoding: .utf8)!
        }
        return String()
    }
}
