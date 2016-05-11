//
//  ProgressViewController.swift
//  SixStrings
//
//  Created by sean on 5/10/16.
//  Copyright © 2016 Sean Johnsen. All rights reserved.
//

import UIKit
import Charts

class ProgressViewController: UIViewController {
    @IBOutlet weak var chartView: BarChartView!
    
    var months: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        chartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries : [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        chartView.data = chartData
        
        chartView.animate(xAxisDuration: 1.0)
        chartView.animate(yAxisDuration: 1.0, easingOption: .EaseInCubic)
    }
}

