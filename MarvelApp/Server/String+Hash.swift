//
//  Hash.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG



//Test:
let md5Data = MD5(string:"Hello")

let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
print("md5Hex: \(md5Hex)")

struct Hash {
    
    static func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
        
        CommonCrypto.md5
    }
}
