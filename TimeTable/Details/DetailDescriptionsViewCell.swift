//
//  DetailDescriptionsViewCell.swift
//  TimeTable
//
//  Created by 현은백 on 2023/06/25.
//

import UIKit
import SwiftUI

class DetailDescriptionsViewCell: UITableViewCell {
    
    static let identifier = "DetailDescriptionsViewCell"
    
    var item: LectureData?
    
    var lectureData: LectureData?
    
    func configure(with item: Item) {
        if let lectureData {
            lectureData.item = item
        } else {
            lectureData = LectureData(item: item)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lectureData = nil
    }
}

struct DetailDescriptionsView: View {
    
    @ObservedObject var lecture: LectureData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(lecture.item.lecture ?? "")
                    .font(.title)
                
                Spacer(minLength: 24)


                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "alarm")
                        Text("강의 시간 : ")
                        HStack {
                            Text(lecture.item.startTime ?? "")
                            Text("-")
                            Text(lecture.item.endTime ?? "")
                            
                        }
                        
                        Text("|")
                        
                        Text(
                            "\((lecture.item.dayofweek ?? []).map { "(\($0.rawValue))" }.joined(separator: ", "))"
                        )
                    }
                    iconLabel(image: "keyboard", title: "교과목 코드 : ", value: lecture.item.code ?? "")
                    iconLabel(image: "person.wave.2", title: "담당 교수 : ", value: lecture.item.professor ?? "")
                    iconLabel(image: "location.north.line.fill", title: "강의실 : ", value: lecture.item.location ?? "")
                }
                .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.leading)
    }
    
    private func iconLabel(image name: String, title: String, value: String) -> some View {
        return HStack(spacing: 8) {
            Image(systemName: name)
                .frame(width: 20, height: 20)
            Text("\(title)")
            Text("\(value)")
        }
    }
}
