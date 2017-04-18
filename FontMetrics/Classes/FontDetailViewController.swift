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

        lineHeightCell.detailTextLabel?.text = "\(font.lineHeight)"
        ascenderSizeCell.detailTextLabel?.text = "\(font.ascender)"
        capHeightCell.detailTextLabel?.text = "\(font.capHeight)"
        xHeightCell.detailTextLabel?.text = "\(font.xHeight)"
        descenderCell.detailTextLabel?.text = "\(font.descender)"

        lineHeightCell.accessoryView = { let view = UIView(frame:CGRect(x:0, y:0, width:20, height: 42)); view.backgroundColor = .white; return view }()
        ascenderSizeCell.accessoryView = { let view = UIView(frame:CGRect(x:0, y:0, width:20, height: 42)); view.backgroundColor = fontMetricView.ascenderColor; return view }()
        capHeightCell.accessoryView = { let view = UIView(frame:CGRect(x:0, y:0, width:20, height: 42)); view.backgroundColor = fontMetricView.capColor; return view }()
        xHeightCell.accessoryView = { let view = UIView(frame:CGRect(x:0, y:0, width:20, height: 42)); view.backgroundColor = fontMetricView.xColor; return view }()
        descenderCell.accessoryView = { let view = UIView(frame:CGRect(x:0, y:0, width:20, height: 42)); view.backgroundColor = fontMetricView.descenderColor; return view }()

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

}
