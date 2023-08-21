//
//  FirestoreService.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class FirestoreService {
    let db = Firestore.firestore()
    var userID = DataManager.sharedInstance.userInfo?.id ?? ""
    
    /**
     @brief userData를 불러온다,
     */
    func getUserData(completion: @escaping (UserModel) -> Void) {
        var names: [String:Any] = [:]
        var result: UserModel?
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(result!) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                if document.documentID == "y527FpLxOC4LWg2jMO01" {
                    names = document.data()
                }
            }
            result = self.dicToObject(objectType: UserModel.self, dictionary: names)
            completion(result!) // 성공 시 이름 배열 전달
        }
    }
    
    /**
     @brief userData를 수정한다,
     */
    func editUserData(name: String, animalName: String, birth: String, gender: String, imageURL: String, type: String, completion: @escaping (UserModel) -> Void) {
        var names: [String:Any] = [:]
        var result: UserModel?
        
        db.collection("users").document("y527FpLxOC4LWg2jMO01").updateData ([
            "id": userID,
            "name" : name,
            "animalName" : animalName,
            "birth" : birth,
            "gender" : gender,
            "imageURL" : imageURL,
            "type" : type
        ])
        result = self.dicToObject(objectType: UserModel.self, dictionary: names)
        completion(result!) // 성공 시 이름 배열 전달
    }
    
    /**
     @brief dailyData를 불러온다,
     */
    func getDailyData(completion: @escaping ([DailyModel]?) -> Void) {
        var names: [[String:Any]] = [[:]]
        var daily: [DailyModel]?
        
        db.collection("daily").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(daily) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                names.append(document.data())
            }
            
            names.remove(at: 0)
            daily = self.dictionaryToObject(objectType: DailyModel.self, dictionary: names)
            completion(daily) // 성공 시 이름 배열 전달
        }
    }
    
    /**
     @brief infoData를 불러온다,
     */
    func getInfoData(completion: @escaping ([InfoModel]?) -> Void) {
        var names: [[String:Any]] = [[:]]
        var info: [InfoModel]?
        
        db.collection("Info").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(info) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                names.append(document.data())
            }
            names.remove(at: 0)
            info = self.dictionaryToObject(objectType: InfoModel.self, dictionary: names)
            completion(info) // 성공 시 이름 배열 전달
        }
    }
    
    /**
     @brief infoData를 불러온다,
     */
    func getReplyData(completion: @escaping (String?) -> Void) {
        var names: String = ""
        var info: [InfoModel]?
        
        db.collection("daily").document().collection(self.userID).document("reply").getDocument { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(names) // 호출하는 쪽에 빈 배열 전달
                return
            }
            names = querySnapshot!.description
            do {
                let jsonCreate = try JSONSerialization.data(withJSONObject: names, options: .prettyPrinted)
                
                // json 데이터를 변수에 삽입 실시
                names = String(data: jsonCreate, encoding: .utf8) ?? ""
            } catch {
                
            }
            //            names = self.dictionaryToObject(objectType: InfoModel.self, dictionary: names)
            completion(names) // 성공 시 이름 배열 전달
        }
    }
    
    /**
     @brief dailyData를 추가한다,
     
     @param content, imageURL
     */
    func addDailyDocument(content: String, imageURL: String, completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        db.collection("daily").document(content).setData([
            "userName": DataManager.sharedInstance.userInfo?.name,
            "content": content,
            "imageURL": imageURL,
            "reply": nil,
            "like": 0
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                completion("Daily Document added")
            }
        }
    }
    
    /**
     @brief daily heart를 추가한다,
     */
    func addDailyLike(content: String, like: Int) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        let replyRef = db.collection("daily").document(content)
        replyRef.updateData([
            "like": like
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                //                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    /**
     @brief dailyReply를 추가한다,
     
     @param reply, content
     */
    func addDailyReply(content: String, reply: [String: String], completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        let replyRef = db.collection("daily").document(content)
        replyRef.updateData([
            "reply": reply
        ]) { err in
            if let err = err {
                completion("Error adding document: \(err)")
            } else {
                completion("Document added")
                //                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    /**
     @brief infoReply를 추가한다,
     
     @param reply, title
     */
    func addInfoReply(title: String,reply: [String: String], completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        let replyRef = db.collection("Info").document(title)
        replyRef.updateData([
            "reply": reply
        ]) { err in
            if let err = err {
                completion("Error adding document: \(err)")
            } else {
                completion("Document added")
//                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    /**
     @brief infoData를 추가한다,
     
     @param content, imageURL
     */
    func addInfoDocument(title: String, content: String, hashTag: String, imageURL: String, completion: @escaping (String) -> Void) {
        // Add a new document with a generated ID
        db.collection("aaa").document(DataManager.sharedInstance.userInfo?.id ?? "").collection("aaa").addDocument(data: [
            "title": title,
            "content": content,
            "hashTag": hashTag,
            "imageURL": imageURL,
            "reply": nil,
            "like": nil
        ]) { err in
            if let err = err {
                CommonUtil.print(output: "Error adding document: \(err)")
            } else {
                completion("Info Document added")
            }
        }
    }
    
    func deleteInfoDocument() {
        db.collection("aaa").document("aaa").delete(){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

extension FirestoreService {
    func dictionaryToObject<T:Decodable>(objectType:T.Type,dictionary:[[String:Any]]) -> [T]? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
        
    }
    
    func dicToObject<T:Decodable>(objectType:T.Type,dictionary:[String:Any]) -> T? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode(T.self, from: dictionaries) else { return nil }
        return objects
        
    }
}
