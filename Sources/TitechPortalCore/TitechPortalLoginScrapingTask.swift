//
//  File.swift
//  
//
//  Created by m.tomoya on 2020/10/24.
//

import Foundation

public struct TitechPortalLoginScrapingTask {
    public static func login(name: String, password: String, matrix: [String:String]) {
        print("login")
        let loginURL = URL(string: "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword")!
        let postURL = URL(string: "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login")!
        
        URLSession.shared
            .dataTask(with: loginURL) { data, response, error in
                let allowedCharacterSet = CharacterSet(charactersIn: "!'();:@&=+$,/?%#[]").inverted
                let inputs = HTMLInputParser.parse(data!).map {
                    var value: String
                    
                    switch $0.name {
                    case "usr_name":
                        value = name
                    case "usr_password":
                        value = password
                    default:
                        value = $0.value
                    }
            
                    let encodedStr = value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?.replacingOccurrences(of: " ", with: "+") ?? ""
                    
                    return "\($0.name)=\(encodedStr)"
                }.joined(separator: "&")
                
                var urlRequest = URLRequest(url: postURL)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = inputs.data(using: .utf8)
                urlRequest.setValue(postURL.absoluteString, forHTTPHeaderField: "Referer")
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    let keys = MatrixKeyParser.parse(data!)
                    let inputs = HTMLInputParser.parse(data!).map {
                        var value: String

                        switch $0.name {
                        case "message3":
                            value = matrix[keys[0]] ?? ""
                        case "message4":
                            value = matrix[keys[1]] ?? ""
                        case "message5":
                            value = matrix[keys[2]] ?? ""
                        default:
                            value = $0.value
                        }

                        let encodedStr = value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?.replacingOccurrences(of: " ", with: "+") ?? ""

                        return "\($0.name)=\(encodedStr)"
                    }.joined(separator: "&")
                    
                    urlRequest.httpBody = inputs.data(using: .utf8)
                    
                    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                        print(String(data: data!, encoding: .utf8)!)
                    }.resume()
                    
                }.resume()
                
            }.resume()
    }
}
