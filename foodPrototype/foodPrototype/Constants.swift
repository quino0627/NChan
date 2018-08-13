//
//  Constants.swift
//  foodPrototype
//
//  Created by 송 on 2018. 7. 27..
//  Copyright © 2018년 송. All rights reserved.
//

import Foundation
import Firebase
struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}

var gpost: PostModel?

// Whenever you now need access to the reference for chat data, you can use:
// Constants.refs.databaseChats
