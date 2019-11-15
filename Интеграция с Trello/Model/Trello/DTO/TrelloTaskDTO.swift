//
//  TrelloTaskDTO.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

public struct TrelloTaskDTO: Codable {
    
    public var id: String?
    public var name: String?
    public var desc: String?
    public var closed: Bool?
    public var idList: String?
    public var idBoard: String?
    
}
