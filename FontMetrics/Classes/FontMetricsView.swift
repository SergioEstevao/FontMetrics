import Foundation
import UIKit

@IBDesignable public class FontMetricsView: UITextField {

    @IBInspectable public var ascenderColor: UIColor = UIColor.red
    @IBInspectable public var descenderColor: UIColor = UIColor.green
    @IBInspectable public var baseLineColor: UIColor = UIColor.lightGray
    @IBInspectable public var capColor: UIColor = UIColor.purple
    @IBInspectable public var xColor: UIColor = UIColor.blue

    public override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.borderStyle = .none
    }

    public override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let font = self.font,
              let context = UIGraphicsGetCurrentContext() else {
            return
        }
        // Drawing code
        var verticalAlignment: CGFloat = 0
        if self.contentVerticalAlignment == .center {
            verticalAlignment = (self.frame.size.height - font.lineHeight) / 2
        } else if self.contentVerticalAlignment == .bottom {
            verticalAlignment = self.frame.size.height - font.lineHeight
        }
        var baseLine: CGFloat = font.lineHeight + font.descender + verticalAlignment
        let ascender = max(floor(baseLine -  font.ascender), 0)
        let descender = floor(baseLine - font.descender)
        let capHeight = ceil(baseLine -  font.capHeight)
        let xHeight = ceil(baseLine - font.xHeight)
        baseLine = ceil(baseLine)

        //baseLine
        context.setLineWidth(2.0)
        context.move(to: CGPoint(x: 0, y: baseLine))
        context.addLine(to: CGPoint(x: frame.size.width, y: baseLine))
        context.setStrokeColor(baseLineColor.cgColor)
        context.strokePath()

        //ascender
        drawMetric(onContext: context, frame: frame, baseline: baseLine,
                   x: 5, value: ascender, color: ascenderColor)

        //descender
        drawMetric(onContext: context, frame: frame, baseline: baseLine,
                   x: 5, value: descender, color: descenderColor)
        //capHeight
        drawMetric(onContext: context, frame: frame, baseline: baseLine,
                   x: 10, value: capHeight, color: capColor)
        //xHeight
        drawMetric(onContext: context, frame: frame, baseline: baseLine,
                   x: 15, value: xHeight, color: xColor)
    }

    func drawMetric(onContext context: CGContext,
                    frame: CGRect,
                    baseline: CGFloat,
                    x: CGFloat,
                    value: CGFloat,
                    color: UIColor) {
        context.move(to: CGPoint(x: x, y: value))
        context.addLine(to: CGPoint(x: frame.size.width, y: value))
        context.setStrokeColor(color.cgColor)
        context.strokePath()
        context.move(to: CGPoint(x: x, y: baseline))
        context.addLine(to: CGPoint(x: x, y: value))
        context.setStrokeColor(color.cgColor)
        context.strokePath()
    }
}
