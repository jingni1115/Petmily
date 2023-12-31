//
//  MyFirestore.swift
//  Petmily
//
//  Created by 김지은 on 2023/08/18.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class MyFirestore {
    let db = Firestore.firestore()
    var id: String = ""
    
    func addDocument(content: String, imageURL: String) {
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("daily").addDocument(data: [
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
    
    func getDocumentID() {
        Firestore.firestore().collection("daily").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.id = document.documentID
                    print("\(document.documentID)") // Get documentID
                }
            }
        }
    }
    
    //    func addData() {
    //        do {
    //            try db.collection("daily").document(id).setData(from: City(id: id, title: "qwe", content: "QWEq"))
    //        } catch let error {
    //            print("Error writing city to Firestore: \(error)")
    //        }
    //    }
    
    func updateData() {
        let washingtonRef = db.collection("cities").document("DC")
        
        // Set the "capital" field of the city 'DC'
        washingtonRef.updateData([
            "capital": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func getDocuments() {
        //        var dic: [DailyModel] = []
        //        let userDocument = self.db.collection("daily")
        //        userDocument.getDocument(completion: { document, error in
        //            guard let user = try! document?.data(as: [DailyModel].self) else { return }
        //            dic = user
        //        })
        //        return dic
        //        db.collection("daily").getDocuments() { (querySnapshot, err) in
        //            if let err = err {
        //                print("Error getting documents: \(err)")
        //            } else {
        //                for document in querySnapshot!.documents {
        //                    print("\(document.documentID) => \(document.data())")
        //                    guard let user = try! document.data(as: [DailyModel]?.self) else { return }
        //                    self.dic = user
        //                }
        //            }
        //        }
        let userDocument = self.db.collection("daily")
        userDocument.getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
            } else {
                guard let snapshot = snapshot else { return }
                for document in snapshot.documents {
                    if document.documentID == self.id {
                        // 서버에 저장된 딕셔너리 데이터를 가져온다.
                        print("here: \(document)")
                        guard let user = try! document.data(as: [DailyModel]?.self) else { return }
                        print("\(self.id) => \(user)")
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
    func getUserData(completion: @escaping (UserModel) -> Void) {
        var names: [String:Any] = [:]
        var mmm: UserModel?
        
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(mmm!) // 호출하는 쪽에 빈 배열 전달
                return
            }
            
            for document in querySnapshot!.documents {
                if document.documentID == "y527FpLxOC4LWg2jMO01" {
                    if let name = document.data() as? [String:Any] {
                        names = name
                    }
                }
            }
            mmm = self.dicToObject(objectType: UserModel.self, dictionary: names)
            completion(mmm!) // 성공 시 이름 배열 전달
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

extension MyFirestore {
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
