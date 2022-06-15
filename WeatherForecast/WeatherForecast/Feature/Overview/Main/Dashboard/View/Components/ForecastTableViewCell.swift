//
//  ForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by User on 15/06/2022.
//

import Foundation
import UIKit
import TSwiftHelper

final class ForecastTableViewCell: UITableViewCell {
    // MARK: UI Properties
    private let containerView = ViewHelper(style: ViewStyle())
    private let seperateView = ViewHelper(style: ViewStyle(backgroundColor: .Silver))
    
    private let weatherImageView = ImageViewHelper(style: ImageViewStyle())
    
    private let dateLb = LabelHelper(style: LabelStyle())
    private let avgTempLb = LabelHelper(style: LabelStyle())
    private let pressureLb = LabelHelper(style: LabelStyle())
    private let humidityLb = LabelHelper(style: LabelStyle())
    private let descLb = LabelHelper(style: LabelStyle())
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
}

// MARK: - Public Functions
extension ForecastTableViewCell {
    // MARK: loadData
    final func loadData(data: ForecastItemInfo?) {
        guard let data = data else {
            return
        }
        
        let dateStr = L10n.Dashboard.Forecast.Cell.Date.title + Date(timeIntervalSince1970: data.dt).toString(format: "E, dd MMM yyyy")
        dateLb.text = dateStr
        
        let avgTempStr = L10n.Dashboard.Forecast.Cell.Average.Temperature.title + data.temp.day.clean + L10n.Dashboard.Forecast.Cell.Average.Temperature.unit
        avgTempLb.text = avgTempStr
        
        let pressureStr = L10n.Dashboard.Forecast.Cell.Pressure.title + data.pressure.clean
        pressureLb.text = pressureStr
        
        let humidityStr = L10n.Dashboard.Forecast.Cell.Humidity.title + data.humidity.clean + L10n.Dashboard.Forecast.Cell.Humidity.unit
        humidityLb.text = humidityStr
        
        var descStr = L10n.Dashboard.Forecast.Cell.Desc.title
        if let desc = data.weather.first?.desc {
            descStr += desc
        }
        
        descLb.text = descStr
        
        if let weather = data.weather.first {
            weatherImageView.image(url: weather.iconURL)
            
            weatherImageView.accessibilityValue = L10n.Dashboard.Forecast.Cell.Cond.title + "\(weather.main.rawValue)"
        }
    }
}

// MARK: - Private Functions
extension ForecastTableViewCell {
    
}

// MARK: - UI Functions
extension ForecastTableViewCell {
    // MARK: setupUI
    final private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        // MARK: containerView
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // MARK: weatherImageView
        weatherImageView.isAccessibilityElement = true
        weatherImageView.accessibilityLabel = "Icon"
        containerView.addSubview(weatherImageView)
        
        weatherImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(4)
            make.width.height.equalTo(100)
        }
        
        // MARK: dateLb
        dateLb.font = UIFont.preferredFont(forTextStyle: .body)
        dateLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(dateLb)
        
        dateLb.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(weatherImageView.snp.left).offset(-4)
        }
        
        // MARK: avgTempLb
        avgTempLb.font = UIFont.preferredFont(forTextStyle: .body)
        avgTempLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(avgTempLb)
        
        avgTempLb.snp.makeConstraints { make in
            make.top.equalTo(dateLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: pressureLb
        pressureLb.font = UIFont.preferredFont(forTextStyle: .body)
        pressureLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(pressureLb)
        
        pressureLb.snp.makeConstraints { make in
            make.top.equalTo(avgTempLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: humidityLb
        humidityLb.font = UIFont.preferredFont(forTextStyle: .body)
        humidityLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(humidityLb)
        
        humidityLb.snp.makeConstraints { make in
            make.top.equalTo(pressureLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: descLb
        descLb.font = UIFont.preferredFont(forTextStyle: .body)
        descLb.adjustsFontForContentSizeCategory = true
        containerView.addSubview(descLb)
        
        descLb.snp.makeConstraints { make in
            make.top.equalTo(humidityLb.snp.bottom).offset(8)
            make.left.right.equalTo(dateLb)
        }
        
        // MARK: seperateView
        containerView.addSubview(seperateView)
        
        seperateView.snp.makeConstraints { make in
            make.left.equalTo(dateLb)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
            make.top.equalTo(descLb.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

