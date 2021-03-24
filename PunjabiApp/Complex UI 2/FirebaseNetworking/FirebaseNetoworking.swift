////
////  FirebaseNetoworking.swift
////  Complex UI 2
////
////  Created by Bharat Kumar on 9/10/20.
////  Copyright © 2020 Balaji. All rights reserved.
////
//import Foundation
//import Firebase
//import FirebaseDatabase
//fileprivate let DB = Database.database().reference()
//class DataService {
//    static let instance = DataService()
//    private let _GROUPS = DB.child("Groups")
//    private let _USERS = DB.child("Users")
//    private let _ROOMS = DB.child("Rooms")
//    var GROUPS: DatabaseReference {
//        return _GROUPS
//    }
//    var USERS: DatabaseReference {
//        return _USERS
//    }
//    var ROOMS: DatabaseReference {
//        return _ROOMS
//    }
//    func query(_ reference: DatabaseReference) -> Any {
//        return " "
//    }
//    func createUser(id: String, userData: Dictionary<String,Any>, complete: @escaping CompletionWithError) {
//        USERS.child(id).updateChildValues(userData) { (error, USERS) in
//            if let error = error {
//                complete(.firebase, error)
//                return
//            }
//            complete(.none, nil)
//        }
//    }
//    func deleteUser(uid: String, complete: @escaping CompletionWithError){
//        USERS.child(uid).removeValue { (error, USERS) in
//            if let error = error {
//                print(error)
//                complete(.firebase, error)
//                return
//            }
//            complete(.none, nil)
//        }
//    }
//    func getUserPriv(room: Room, userUid: String, complete: @escaping CompletionWithPriv) {
//        var priv = privilege.User
//        for (key, value) in room.privileges {
//            if userUid == key {
//                priv = value
//            }
//        }
//        complete(priv)
//    }
//    func addRoom(roomDict: Dictionary<String, Any>, complete: @escaping CompletionWithError) {
//        //roomDict should contain room ID, room name and privileges
//        ROOMS.observeSingleEvent(of: .value, with: { (snapshot) in
//            if let id = roomDict.keys.first {
//                //check to see if ID already exists (extremely unlikely)
//                if !snapshot.hasChild(id){
//                    if let roomVals = roomDict[id] as? [String:Any] {
//                        //check to see if room name exists
//                        if let roomName = roomVals["name"] as? String {
//                            for rest in snapshot.children.allObjects as! [DataSnapshot] {
//                               let restDict = rest.value as? [String:Any]
//                                if let name = restDict?["name"] as? String{
//                                    if roomName.lowercased() == name.lowercased() {
//                                        complete(.nameExists, nil)
//                                        return
//                                    }
//                                }
//                            }
//                            //update database, add room
//                            self.ROOMS.updateChildValues(roomDict) {
//                                   (error, ROOMS) in
//                                   if error != nil {
//                                       complete(.firebase, error)
//                                       return
//                                   }
//                                complete(.none, nil)
//                                return
//                               }
//                        } //end RoomName
//                    } //end RoomVals dict is of type
//                 } else {
//                    complete(.IDExists, nil)
//                }
//            }
//        })
//    }
//    func deleteRoom(roomId: String, complete: @escaping CompletionWithError) {
//        ROOMS.child(roomId).removeValue { (error, ROOMS) in
//            if let error = error {
//                complete(.firebase, error)
//                return
//            }
//            complete(.none, nil)
//        }
//    }
//    func addUserToRoom(room: Room, userDict: Dictionary<String, Any>, complete: @escaping CompletionWithError) {
//        //userDict in this instance should be [user.uid:privelege.rawValue] ([String:String])
//        ROOMS.child(room.id).child("users").updateChildValues(userDict) { (error, ROOMS) in
//            if let error = error {
//                complete(.firebase, error)
//                return
//            }
//            guard let user = userDict.first?.key else {return}
//            guard let priv = userDict[user] as? String else {return}
//            complete(.none, nil)
//        }
//    }
//    func removeUserFromRoom(room: Room, userUid: String, complete: @escaping CompletionWithError) {
//        ROOMS.child(room.id).child("users").child(userUid).removeValue { (error, ROOMS) in
//            if let error = error {
//                complete(.firebase, error)
//                return
//            }
//            complete(.none, nil)
//        }
//        //WHY?
////        if room.users.count == 0 {
////            self.userAddedToRoomListener(room: room) { (username, uid) in
////
////            }
////        }
//    }
//    func userAddedToRoomListener(room: Room, _ complete: @escaping CompletionWithUsernameAndUid) {
//        ROOMS.child(room.id).child("users").observe(.childAdded) { (snapshot) in
//            let key = snapshot.key
//            self.getUsernameFromUid(uid: key) { (username) in
//                complete(username, key)
//            }
//        }
//    }
//    func userLeftRoomListener(room: Room, _ complete: @escaping CompletionWithUsernameAndUid) {
//        ROOMS.child(room.id).child("users").observe(.childRemoved) { (snapshot) in
//            let key = snapshot.key
//            self.getUsernameFromUid(uid: key) { (username) in
//                complete(username, key)
//            }
//        }
//    }
//    func roomListener(_ complete: @escaping CompletionWithRoom) {
//        _ROOMS.observe(.childAdded) { (snapshot) in
//            var room: Room
//            let key = snapshot.key
//            let name = snapshot.childSnapshot(forPath: "name")
//            let users = snapshot.childSnapshot(forPath: "users")
//            let privileges = snapshot.childSnapshot(forPath: "privileges")
//            if let nameValue = name.value as? String {
//                if let usersValue = users.value as? [String:String] {
//                    if let privilegesValue = privileges.value as? [String:String] {
//                        room = Room(name: nameValue, privileges: privilegesValue, id: key, users: usersValue)
//                        complete(room)
//                        return
//                    }
//                } else {
//                    if let privilegesValue = privileges.value as? [String:String] {
//                        room = Room(name: nameValue, privileges: privilegesValue, id: key, users: ["":""])
//                        complete(room)
//                        return
//                    }
//                }
//            }
//        }
//        complete(nil)
//    }
//    func removeRoomListener(_ complete: @escaping CompletionWithRoom) {
//        //for updating GroupsController UI when a room is deleted
//        _ROOMS.observe(.childRemoved) { (snapshot) in
//                var room: Room
//                let key = snapshot.key
//                let name = snapshot.childSnapshot(forPath: "name")
//                let users = snapshot.childSnapshot(forPath: "users")
//                let privileges = snapshot.childSnapshot(forPath: "privileges")
//                if let nameValue = name.value as? String {
//                    if let usersValue = users.value as? [String:String] {
//                        if let privilegesValue = privileges.value as? [String:String] {
//                            room = Room(name: nameValue, privileges: privilegesValue, id: key, users: usersValue)
//                            complete(room)
//                            return
//                        }
//                    } else {
//                        if let privilegesValue = privileges.value as? [String:String] {
//                            room = Room(name: nameValue, privileges: privilegesValue, id: key, users: ["":""])
//                            complete(room)
//                            return
//                        }
//                    }
//                }
//            }
//            complete(nil)
//    }
//    func addMessage(roomId: String, body: String, username: String, messageId: String, uid: String) {
//        var messageDict = Dictionary<String,Any>()
//        let date = NSDate().timeIntervalSince1970
//        messageDict[messageId] = ["body":body,"username":username,"uid":uid,"date":date]
//        _ROOMS.child(roomId).child("messages").updateChildValues(messageDict) { (error, _ROOMS) in
//            if let error = error {
//                print(error)
//            }
//        }
//    }
//    func messageListener(roomId: String, _ complete: @escaping CompletionWithMessage) {
//        _ROOMS.child(roomId).child("messages").observe(.childAdded) { (snapshot) in
//            let messageBody = snapshot.childSnapshot(forPath: "body")
//            let username = snapshot.childSnapshot(forPath: "username")
//            let uid = snapshot.childSnapshot(forPath: "uid")
//            if let date = snapshot.childSnapshot(forPath: "date").value as? Double {
//                let idValue = snapshot.key
//                if let bodyValue = messageBody.value as? String {
//                    if let username = username.value as? String {
//                        if let uid = uid.value as? String {
//                            let message = Message(id: idValue, body: bodyValue, user: username, uid: uid)
//                            message.setDate(date)
//                            complete(message)
//                        }
//                    }
//                }
//            }
//        }
//    }
//    func checkEmail(email: String, complete: @escaping CompletionWithError) {
//        USERS.observeSingleEvent(of: .value, with: { (snapshot) in
//            for snap in snapshot.children.allObjects as! [DataSnapshot] {
//                let snapDict = snap.value as? [String:Any]
//                if let name = snapDict?["email"] as? String {
//                    print(name)
//                    if name == email {
//                        complete(.nameExists, nil)
//                        return
//                    }
//                }
//            }
//            complete(.none, nil)
//            return
//        })
//    }
//    func getUsernameFromUid(uid: String, complete: @escaping CompletionWithString) {
//        var username = ""
//        USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            let dict = snapshot.value as? Dictionary<String, Any>
//            guard  let dictName = dict?["username"] as? String else {return}
//            username = dictName
//            complete(username)
//        }
//    }
//}
