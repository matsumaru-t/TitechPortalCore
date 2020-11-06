//
//  File.swift
//  
//
//  Created by m.tomoya on 2020/10/24.
//

import Foundation

public struct TitechPortalLoginScrapingTask {
    public static func login() {
        print("login")
        URLSession.shared
            .dataTask(with: URL(string: "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword")!) { data, response, error in
//                print(response)
//                print(String(data: data!, encoding: .utf8))
                let allowedCharacterSet = CharacterSet(charactersIn: "!'();:@&=+$,/?%#[]").inverted
                let inputs = HTMLInputParser.parse(data!).map {
                        var value: String
                        
                        switch $0.name {
                        case "usr_name":
                            value = MyData.usrName
                        case "usr_password":
                            value = MyData.usrPassword
                        default:
                            value = $0.value
                    }
            
                    let encodedStr = value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?.replacingOccurrences(of: " ", with: "+") ?? ""
                    
                    return "\($0.name)=\(encodedStr)"
                }.joined(separator: "&")
                
//                print(inputs.replacingOccurrences(of: MyData.usrPassword, with: "aaaaaaaa"))
                
                var urlRequest = URLRequest(url: URL(string: "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login")!)
                urlRequest.httpMethod = "POST"
                urlRequest.httpBody = inputs.data(using: .utf8)
                urlRequest.setValue("https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword", forHTTPHeaderField: "Referer")
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    let keys = MatrixKeyParser.parse(data!)
                    let inputs = HTMLInputParser.parse(data!).map {
                            var value: String

                            switch $0.name {
                            case "message3":
                                value = MyData.matrix[keys[0]] ?? ""
                            case "message4":
                                value = MyData.matrix[keys[1]] ?? ""
                            case "message5":
                                value = MyData.matrix[keys[2]] ?? ""
                            default:
                                value = $0.value
                        }

                        let encodedStr = value.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)?.replacingOccurrences(of: " ", with: "+") ?? ""

                        return "\($0.name)=\(encodedStr)"
                    }.joined(separator: "&")
                    
                    var urlRequest = URLRequest(url: URL(string: "https://portal.nap.gsic.titech.ac.jp/GetAccess/Login")!)
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = inputs.data(using: .utf8)
                    urlRequest.setValue("https://portal.nap.gsic.titech.ac.jp/GetAccess/Login?Template=userpass_key&AUTHMETHOD=UserPassword", forHTTPHeaderField: "Referer")
                    
                    URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                        print(String(data: data!, encoding: .utf8)!)
                    }.resume()
                    
                }.resume()
                
            }.resume()
    }
}
