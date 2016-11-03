//
//  TLV.swift
//  TLVDemo
//
//  Created by dada on 2016/11/3.
//  Copyright © 2016年 dada. All rights reserved.
//

import Foundation

class Tlv {
    let tlvTagByte = 1
    let tlvLengthByte = 2
    let intByte = 4
    let longByte = 8
    
    var data: Data = Data()
    var tlvArray: Array = Array<TlvEntity>()
    
    //TLV编码相关
    func encode() -> Data {
        return self.data
    }
    
    func packageTlv(tag: UInt8, length: UInt16, data: Data) {
        
        self.data.append(ByteConverter.byteFromUint8(value: tag))
        self.data.append(ByteConverter.byteFromUint16(value: length))
        self.data.append(data)
    }
    
    func pushUInt8(value: UInt8, tag: UInt8) {
        //self.packageTlv(from: value, length: sizeof(UInt8), data: ByteConverter.byteFromUint8(value: <#T##UInt8#>))
        self.packageTlv(tag: tag, length: UInt16(MemoryLayout<UInt8>.size), data: ByteConverter.byteFromUint8(value: value))
    }
    
    func pushUInt16(value: UInt16, tag: UInt8) {
        self.packageTlv(tag: tag, length: UInt16(MemoryLayout<UInt16>.size), data: ByteConverter.byteFromUint16(value: value))
    }
    
    func pushUInt32(value: UInt32, tag: UInt8) {
        self.packageTlv(tag: tag, length: UInt16(MemoryLayout<UInt32>.size), data: ByteConverter.byteFromUint32(value: value))
    }
    
    func pushString(value: String, tag: UInt8) {
        let byteData: Data = ByteConverter.byteFromString(value: value)
        let dataLength: UInt16 = UInt16(byteData.count)
        self.packageTlv(tag: tag, length: dataLength, data: byteData)
    }
    
    //TLV解码相关
    func decode(from data: Data) {
        var index = 0
        while index < data.count {
            //var tagData = Data(count: MemoryLayout<UInt8>.size)
            let tagRange: Range<Int> = index..<(tlvTagByte + index)
            let tagData = data.subdata(in: tagRange)
            let tag = ByteConverter.uint8FromData(data: tagData)
            index += tlvTagByte
            
            let lengthRange: Range<Int> = index..<(tlvLengthByte + index)
            let lengthData = data.subdata(in: lengthRange)
            let length = ByteConverter.uint16FromData(data: lengthData)
            index += tlvLengthByte
            
            let valueRange: Range<Int> = index..<(Int(length) + index)
            let valueData = data.subdata(in: valueRange)
            index += Int(length)
            
            self.data = valueData
            
            let tlvEntity: TlvEntity = TlvEntity()
            tlvEntity.tag = tag
            tlvEntity.length = length
            tlvEntity.value = valueData
            
            self.tlvArray.append(tlvEntity)
        }
    }
    
    func getTlvFromTlvArray(tag: UInt8) -> TlvEntity {
        for item in self.tlvArray.enumerated() {
            if item.element.tag == tag {
                return item.element
            }
        }
        return TlvEntity()
    }
    
    func getUInt8(tag: UInt8) -> UInt8 {
        let tlvEntity = self.getTlvFromTlvArray(tag: tag)
        guard tlvEntity.value?.count == 0 else {
            return ByteConverter.uint8FromData(data: tlvEntity.value!)
        }
        return 0
    }
    
    func getUInt16(tag: UInt8) -> UInt16 {
        let tlvEntity = self.getTlvFromTlvArray(tag: tag)
        guard tlvEntity.value?.count == 0 else {
            return ByteConverter.uint16FromData(data: tlvEntity.value!)
        }
        return 0
    }
    
    func getUInt32(tag: UInt8) -> UInt32 {
        let tlvEntity = self.getTlvFromTlvArray(tag: tag)
        guard tlvEntity.value?.count == 0 else {
            return ByteConverter.uint32FromData(data: tlvEntity.value!)
        }
        return 0
    }
    
    func getString(tag: UInt8) -> String {
        let tlvEntity = self.getTlvFromTlvArray(tag: tag)
        guard tlvEntity.value?.count == 0 else {
            return ByteConverter.stringFromData(data: tlvEntity.value!)
        }
        return String()
    }
}
