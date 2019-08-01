//
//  XYMarkerView.swift
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation
import Charts

open class XYMarkerView: BalloonMarker
{
    @objc open var xAxisValueFormatter: IAxisValueFormatter?
    @objc public var yFormatter = NumberFormatter()
    
    @objc public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter )
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
    }
    
    @objc public func setminimumDigits(minFractionDigits: Int, maxFractionDigits:Int, minIntegerDigits:Int, maxIntegerDigits: Int)
    {
        yFormatter.minimumFractionDigits = minFractionDigits
        yFormatter.maximumFractionDigits = maxFractionDigits
        yFormatter.minimumIntegerDigits = minIntegerDigits;
        //yFormatter.maximumIntegerDigits = maxIntegerDigits;
    }
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        
        let entryX = entry.x - entry.x.truncatingRemainder(dividingBy: 1.0)
        setLabel(xAxisValueFormatter!.stringForValue(entryX, axis: nil)  + ":" + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!)
    }
    
}
