//
//  musicModel.swift
//  FLO
//
//  Created by 황윤경 on 2021/10/01.
//

import UIKit
import Alamofire

class MusicModel {
    var musicFiles = [Music]()
    
    func getData() {
        AF.request("https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json").responseJSON { response in
            
            switch response.result {
            case .success(let data):
                do {
//                    print(data)
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder() // JSON 데이터를 해석하는 애
                    let dummy_data = try decoder.decode(Music.self, from: jsonData)
                    self.musicFiles[0].title = dummy_data.title
                    print(self.musicFiles[0].title)
                } catch {
                    debugPrint(error)
                }
                
                
//            case .failure(let data):
//                print("fail")
//                return
            default:
                return
            }
        }
    }
}
struct Music: Decodable {
    var singer: String
    var album: String
    var title: String
    var image: String
    var file: String
    var lyrics: String
}

class MusicFile {
    var singer: String = ""
    var album: String = ""
    var title: String = ""
    var image: String = ""
    var file: String = ""
    var lyrics: String = ""
}



// 예외처리 & 오류 처리 해야하나?
// 노래 하나만 처리하면 되나?
