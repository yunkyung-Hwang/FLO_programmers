//
//  ViewController.swift
//  programmersAssignment
//
//  Created by 황윤경 on 2021/09/30.
//
// [전체 가사 보기 화면]
// - 특정 가사로 이동할 수 있는 토글 버튼
// - 전체 가사 화면 닫기 버튼
// - Seekbar
// - Play/Stop 버튼

import UIKit

class lyricsViewController: UIViewController {
    @IBOutlet weak var lyricsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        lyricsTable.dataSource = self
        lyricsTable.backgroundColor = .clear
        lyricsTable.separatorStyle = .none
    }
}
extension lyricsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.lyrics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lyricsTable.dequeueReusableCell(withIdentifier: "lyricsCell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.textLabel?.text = ViewController.lyrics[indexPath.row]
        return cell
    }
}
