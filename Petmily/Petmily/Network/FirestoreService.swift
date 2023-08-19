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
    var id: String = ""
    var userID = DataManager.sharedInstance.userInfo?.id ?? ""
    
    // UserInfo 데이터 불러오기
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
    
    // Daily Document 추가
    func addDailyDocument(content: String, imageURL: String) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("daily").document().collection(self.userID).addDocument(data: [
            "content": content,
            "imageURL": imageURL
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // Daily의 Reply 추가
    func addDailyReply(reply: String) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        let replyRef = db.collection("daily").document().collection(self.userID).document("reply")
        replyRef.updateData([
            "content": reply
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
//    func getDocumentID() {
//        Firestore.firestore().collection("daily").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    self.id = document.documentID
//                    print("\(document.documentID)") // Get documentID
//                }
//            }
//        }
//    }
    
    //    func addData() {
    //        do {
    //            try db.collection("daily").document(id).setData(from: City(id: id, title: "qwe", content: "QWEq"))
    //        } catch let error {
    //            print("Error writing city to Firestore: \(error)")
    //        }
    //    }
    
    func getDailyDocuments() {
        let userDocument = self.db.collection("daily")
        userDocument.getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
            } else {
                guard let snapshot = snapshot else { return }
                for document in snapshot.documents {
                    if document.documentID == self.id {
                        // 서버에 저장된 딕셔너리 데이터를 가져온다.
                        guard let data = try! document.data(as: [DailyModel]?.self) else { return }
                        print("\(self.userID) => \(data)")
                        //                        guard var data = document["Map"] as? [String : String] else { return }
                        //                        // 딕셔너리 데이터를 직접 삭제
                        //                        data["Key1"] = nil
                        //                        // 원하는 아이템이 삭제된 딕셔너리를 다시 서버에 저장
                        //                        path.document("ExampleDocument1").updateData(["Map" : data])
                    }
                }
            }
        }
    }
    
    
    // 데이터 읽어오기
    func fetchUserData(completion: @escaping ([DailyModel]) -> Void) {
        var names: [[String:Any]] = [[:]]
        var mmm: [DailyModel]?
        
        db.collection("daily").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(mmm!) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                if let name = document.data() as? [String:Any] {
                    names.append(name)
                }
            }
            names.remove(at: 0)
            mmm = self.dictionaryToObject(objectType: DailyModel.self, dictionary: names)
            completion(mmm!) // 성공 시 이름 배열 전달
        }
    }
    
    // 데이터 읽어오기
    func fetchInfoData(completion: @escaping ([InfoModel]) -> Void) {
        var names: [[String:Any]] = [[:]]
        var mmm: [InfoModel]?
        
        db.collection("Info").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(mmm!) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                if let name = document.data() as? [String:Any] {
                    names.append(name)
                }
            }
            names.remove(at: 0)
            mmm = self.dictionaryToObject(objectType: InfoModel.self, dictionary: names)
            completion(mmm!) // 성공 시 이름 배열 전달
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
