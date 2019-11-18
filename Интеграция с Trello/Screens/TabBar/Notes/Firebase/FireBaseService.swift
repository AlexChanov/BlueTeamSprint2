//
//  FireBaseService.swift
//  AppStructure
//
//  Created by Oleg Azhel on 16.11.2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit

class FirebaseClient {

//    AIzaSyDgPr4UGXjnBlVVE4b92sfPPHJlB5WHuNQ
    static let apiKey = "AIzaSyDgPr4UGXjnBlVVE4b92sfPPHJlB5WHuNQ"


    enum Endpoints {
        static let base = "https://blueteamtrello.firebaseio.com/"
        static let apiKeyParam = ".json?avvrdd_token=\(FirebaseClient.apiKey)"


        case getNotes


        var stringValue: String {
            switch self {
            case .getNotes:
                return Endpoints.base + Endpoints.apiKeyParam
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }

    }

    // MARK: - GET Requests
    
    // Generic method for GET requests:
    @discardableResult class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        let config = URLSessionConfiguration.default
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        let task = URLSession(configuration: config).dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {

				let responseObject = try decoder.decode(ResponseType.self, from: data)

                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(FirebaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }


    class func getNotes(completion: @escaping ([Note?], Error?) -> Void) {
		taskForGETRequest(url: Endpoints.getNotes.url, responseType: [Note?].self) { (response, error) in
			if let response = response {
                completion(response, nil)
            } else {
                completion([], error)
            }
        }
    }


    // MARK: - PUT Requests
    
    // Generic method for PUT requests:
    // Через этот метод можно добавлять и изменять заметки
    
    class func taskForPUTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)

        let config = URLSessionConfiguration.default

        let task = URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(FirebaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }

    class func putNote(index: Int, noteBody: String, imageUrl: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = Note(body: noteBody, imageUrl: imageUrl)
        let url = URL(string: Endpoints.base + "/\(index)" + Endpoints.apiKeyParam)!
        taskForPUTRequest(url: url, responseType: FirebaseResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                completion(false, error)
            }
        }
    }

    // MARK: - Delete Request
    
    class func deleteNote(index: Int, completion: @escaping () -> Void) {
        let url = URL(string: Endpoints.base + "/\(index)" + Endpoints.apiKeyParam)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")


        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("Successfully deleted note at index: \(index)")
        }
        task.resume()
    }

    // MARK: - Upload Image
	class func uploadNew(image: UIImage, handler: @escaping (String) -> Void) {
		let compressedImage = image.jpegData(compressionQuality: 0.0)
		let url = URL(string: "https://www.googleapis.com/upload/storage/v1/b/blueteamtrello.appspot.com/o/?uploadType=media&name=\(arc4random()).jpg")!
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
		request.httpBody =  Data(compressedImage!)
		URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
			guard let data = data, error == nil else {return}
			do {
				let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
				let imageUrl = dictionary["mediaLink"] as! String
				handler(imageUrl)
			} catch let error as NSError {
                print(error)
            }
		}).resume()
	}
	
//	class func deleteImage(imageUrl: String) {
//        let url = URL(string: imageUrl)!
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//			print("Deleted image: \(imageUrl)")
//        }
//        task.resume()
//    }
}

struct FirebaseResponse: Codable {

    let statusCode: Int
    let statusMessage: String

}

extension FirebaseResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
