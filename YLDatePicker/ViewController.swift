//
//  ViewController.swift
//  YLDatePicker
//
//  Created by Yeonluu on 2019/10/28.
//  Copyright © 2019 Yeonluu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /// 时间选择弹框
    lazy var datePopup: YLDatePickerPopup! = {
        let datePopup = YLDatePickerPopup.init(dateRangeType: .fullDateAndTime, beginDate: nil, endDate: Date(year: Date().year+1, month: 12, day: 31, hour: 23, minute: 59, second: 59))
        datePopup.confirmBlock = { [unowned self, unowned datePopup] _ in
            if let path = datePopup.fromIndexPath {
                self.dataSource[path.row].2 = datePopup.getSelectedDate()
                self.dataSource[path.row].3 = datePopup.getSelectedDateString()
                self.tableView.reloadRows(at: [path], with: .none)
            }
            return true
        }
        return datePopup
    }()
    
    var tableView: UITableView!
    var segmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmented = UISegmentedControl.init(items: ["从底部弹出", "从中间弹出"])
        segmented.frame = CGRect(x: (SCREEN_WIDTH-200)/2, y: 30, width: 200, height: 40)
        segmented.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
        segmented.selectedSegmentIndex = 0
        segmented.setTitleTextAttributes([.foregroundColor : UIColor.white, .font : UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        segmented.selectedSegmentTintColor = datePopup.tintColor
        view.addSubview(segmented)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-150), style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func segmentValueChanged(_ segment: UISegmentedControl) {
        datePopup.showType = segment.selectedSegmentIndex == 0 ? .fromBottom : .fromCenter
    }
    
    typealias SourceType = (String, YLDatePickerView.DateRangeType, Date?, String)
    
    
    private var dataSource: [SourceType] = [  ("年月日时分", .fullDateAndTime, nil, ""),
                                      ("年月日", .fullDate, nil, ""),
                                      ("月日时分", .dateAndTime, nil, ""),
                                      ("月日", .date, nil, ""),
                                      ("时分", .time, nil, "") ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = dataSource[indexPath.row].0
        cell!.detailTextLabel?.text = dataSource[indexPath.row].3
        cell!.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = dataSource[indexPath.row].1
        datePopup.fromIndexPath = indexPath
        datePopup.datePicker.dateRangeType = type
        datePopup.setSelectedDate(dataSource[indexPath.row].2)
        datePopup.showView()
    }
    
}

