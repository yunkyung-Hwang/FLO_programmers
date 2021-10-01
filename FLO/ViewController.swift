//
//  ViewController.swift
//  FLO
//
//  Created by 황윤경 on 2021/09/30.
//
// [음악 재생 화면]
// - 재생 중인 음악 정보(제목, 가수, 앨범 커버 이미지, 앨범명)
// - 현재 재생 중인 부분의 가사 하이라이팅
// - Seekbar
// - Play/Stop 버튼

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var lyricsPicker: UIPickerView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicSinger: UILabel!
    @IBOutlet weak var musicImg: UIImageView!
    public static var lyrics: [String] = []
    
//    private let music = MusicModel()
//    var music = MusicFile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        musicImg.layer.cornerRadius = 7
        
        lyricsPicker.delegate = self
        lyricsPicker.dataSource = self
        
        // 디스패치 큐 써보기
//        music.getData()
//        print(music.musicFiles[0].title)
        getData()
//        print(music.title)
    }

    func getData() {
        AF.request("https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/song.json").responseJSON { response in
            
            switch response.result {
            case .success(let data):
                do {
//                    print(data)
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                    let decoder = JSONDecoder() // JSON 데이터를 해석하는 애
                    let dummy_data = try decoder.decode(Music.self, from: jsonData)
//                    self.music.title = dummy_data.title
                    self.musicTitle.text = dummy_data.title
                    let imgURL = URL(string: dummy_data.image)
                    let data = try Data(contentsOf: imgURL!)
                    self.musicImg.image = UIImage(data: data)
                    self.musicSinger.text = dummy_data.singer
                    ViewController.lyrics = dummy_data.lyrics.split(separator: "\n").map{String($0)}
                    self.lyricsPicker.reloadAllComponents()
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
    
    
    override func viewDidLayoutSubviews() {
        lyricsPicker.subviews[1].isHidden = true
    }
    
}
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ViewController.lyrics.count
    }
    
    // 텍스트 설정
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 16)
        label.textColor = .white
        label.text = ViewController.lyrics[row]
        label.textAlignment = .center
        return label
    }
    
    // 줄간격
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 20
    }
}

// 0. 상단 시간 및 배터리 색 자동으로 안바뀌나
// 1. 제공되는 아이콘 크기 변경 안됨?
// 2. 가사 pickerview 사용 or 그냥 label
// 3. 가사 화면 전환 새로운 뷰 파서 현재화면의 데이터전송 or 컨테이너뷰
// 4. 새로운 뷰로 해서 전달하면 끊김 현상 없을까???

// 5. 검색해보니께 고려해야할 상황이 생각보다 많음... 뭐야..
