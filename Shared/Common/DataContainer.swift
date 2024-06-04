//
//  DataContainer.swift
//  Shared
//
//  Created by Herlemann, Christian [CBC] on 29.07.23.
//

// MARK: DataWrapper
public struct DataWrapper<ResponseModel: Decodable>: Decodable {
    public let data: DataContainer<ResponseModel>
}

// MARK: DataContainer
public struct DataContainer<ResponseModel: Decodable>: Decodable {
    public let results: ResponseModel
}
