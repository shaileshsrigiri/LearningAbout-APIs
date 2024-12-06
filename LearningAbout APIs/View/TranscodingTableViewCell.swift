//
//  TranscodingTableViewCell.swift
//  LearningAbout APIs
//
//  Created by Shailesh Srigiri on 12/2/24.
//

import UIKit

class TranscodingTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let bitrateLabel = UILabel()
    let sizeLabel = UILabel()
    let dimensionsLabel = UILabel()
    let httpUriLabel = UILabel()
    let progressLabel = UILabel()
    let rtmpStreamUriLabel = UILabel()
    let rtmpUriLabel = UILabel()
    let rtmpBaseUriLabel = UILabel()
    let stateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labels = [titleLabel, bitrateLabel, sizeLabel, dimensionsLabel, httpUriLabel,
            progressLabel, rtmpStreamUriLabel, rtmpUriLabel, rtmpBaseUriLabel, stateLabel
        ]

        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black

        bitrateLabel.font = UIFont.systemFont(ofSize: 14)
        bitrateLabel.textColor = .darkGray

        sizeLabel.font = UIFont.systemFont(ofSize: 14)
        sizeLabel.textColor = .darkGray

        dimensionsLabel.font = UIFont.systemFont(ofSize: 14)
        dimensionsLabel.textColor = .darkGray

        httpUriLabel.font = UIFont.systemFont(ofSize: 12)
        httpUriLabel.textColor = .systemBlue
        httpUriLabel.numberOfLines = 0

        progressLabel.font = UIFont.systemFont(ofSize: 14)
        progressLabel.textColor = .gray
        
        rtmpStreamUriLabel.font = UIFont.systemFont(ofSize: 12)
        rtmpStreamUriLabel.textColor = .systemBlue
        rtmpStreamUriLabel.numberOfLines = 0
        
        rtmpUriLabel.font = UIFont.systemFont(ofSize: 12)
        rtmpUriLabel.textColor = .systemBlue
        rtmpUriLabel.numberOfLines = 0
        
        rtmpBaseUriLabel.font = UIFont.systemFont(ofSize: 12)
        rtmpBaseUriLabel.textColor = .systemBlue
        rtmpBaseUriLabel.numberOfLines = 0
        
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        stateLabel.textColor = .darkGray

        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        contentView.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with transcoding: Transcodings) {
        titleLabel.text = "Title: \(transcoding.title)"
        bitrateLabel.text = "Bitrate: \(transcoding.bitrate) kbps"
        sizeLabel.text = "Size: \(transcoding.size) bytes"
        dimensionsLabel.text = "Dimensions: \(transcoding.width)x\(transcoding.height)"
        httpUriLabel.text = "HTTP URI: \(transcoding.http_uri)"
        progressLabel.text = "Progress: \(transcoding.progress * 100)%"
        rtmpStreamUriLabel.text = "RTMP Stream URI: \(transcoding.rtmp_stream_uri)"
        rtmpUriLabel.text = "RTMP URI: \(transcoding.rtmp_uri)"
        rtmpBaseUriLabel.text = "RTMP Base URI: \(transcoding.rtmp_base_uri)"
        stateLabel.text = "State: \(transcoding.state)"
    }
}
