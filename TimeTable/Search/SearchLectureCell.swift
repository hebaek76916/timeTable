//
//  SearchLectureCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/24.
//

import UIKit
import SwiftUI

class LectureData: ObservableObject {
    @Published var item: Item
    
    init(item: Item) {
        self.item = item
        
    }
}

class SearchLectureCell: UITableViewCell {
    
    static let identifier = "SearchLectureCell"
    
    var lectureData: LectureData?
    
    func configure(with lecture: Item) {
        if let lectureData = lectureData {
            lectureData.item = lecture
        } else {
            lectureData = LectureData(item: lecture)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lectureData = nil
    }
}


struct LectureView: View {
    
    @ObservedObject var lecture: LectureData

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(lecture.item.lecture ?? "")
                .font(.title)
            HStack {
                Image(systemName: "clock")
                HStack {
                    Text(lecture.item.startTime ?? "")
                    Text("-")
                    Text(lecture.item.endTime ?? "")
                    
                }
                
                Text("|")
                
                ForEach((lecture.item.dayofweek ?? []), id: \.self) { weekDay in
                    Text("(\(weekDay.rawValue))")
                }
                
            }
            VStack(alignment: .leading) {
                Text("교과목 코드 : \(lecture.item.code ?? "")")
                Text("담당 교수 : \(lecture.item.professor ?? "")")
                Text("강의실 : \(lecture.item.location ?? "")")
            }
            .foregroundColor(.gray)
        }
        .padding()
        
        
    }
}

struct LectureView_Previews: PreviewProvider {
    
    static var previews: some View {
        LectureView(
            lecture: LectureData(
                item:
                    Item(
                        dayofweek: [.월, .금],
                        code: "AAAA-AA",
                        location: "위치",
                        lecture: "프로그래밍 기초",
                        professor: "김말똥",
                        startTime: "10:00",
                        endTime: "11:00"
                    )
            )
        )
    }
}
