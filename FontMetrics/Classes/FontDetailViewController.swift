import UIKit

public class FontDetailViewController: UITableViewController {

    @IBOutlet weak var fontMetricView: FontMetricsView!
    @IBOutlet weak var lineHeightCell: UITableViewCell!
    @IBOutlet weak var ascenderSizeCell: UITableViewCell!
    @IBOutlet weak var capHeightCell: UITableViewCell!
    @IBOutlet weak var xHeightCell: UITableViewCell!
    @IBOutlet weak var descenderCell: UITableViewCell!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeSlider: UISlider!

    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        lineHeightCell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        ascenderSizeCell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        capHeightCell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        xHeightCell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        descenderCell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        configureView()
        tableView.reloadData()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    var font: UIFont? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        guard isViewLoaded, let font = font else {
            return
        }
        self.title = font.fontName
        fontMetricView.font = font
        fontMetricView.sizeToFit()


        lineHeightCell.detailTextLabel?.text = valueFor(metric: font.lineHeight)
        ascenderSizeCell.detailTextLabel?.text = valueFor(metric: font.ascender)
        capHeightCell.detailTextLabel?.text = valueFor(metric: font.capHeight)
        xHeightCell.detailTextLabel?.text = valueFor(metric: font.xHeight)
        descenderCell.detailTextLabel?.text = valueFor(metric: font.descender)

        lineHeightCell.accessoryView = labelView(color: .white)
        ascenderSizeCell.accessoryView = labelView(color: fontMetricView.ascenderColor)
        capHeightCell.accessoryView = labelView(color: fontMetricView.capColor)
        xHeightCell.accessoryView = labelView(color: fontMetricView.xColor)
        descenderCell.accessoryView = labelView(color: fontMetricView.descenderColor)

        sizeLabel.text = "\(font.pointSize) pt"
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func changeSize(sender: UISlider) {
        let newSize = CGFloat(floor(sender.value))
        font = font?.withSize(newSize)
        tableView.reloadSections(IndexSet([0]), with: .none)
    }

    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 3
        return formatter
    }()

    func valueFor(metric: CGFloat) -> String {
        guard let result = numberFormatter.string(from: NSNumber(value: Float(fabs(metric)))) else {
            return "NA"
        }
        return result
    }

    func labelView(color: UIColor) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.backgroundColor = color
        view.layer.cornerRadius = 5
        return view
    }

}
