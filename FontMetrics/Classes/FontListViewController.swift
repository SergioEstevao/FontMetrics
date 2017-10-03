import UIKit

class FontListViewController: UITableViewController {

    var detailViewController: FontDetailViewController? = nil
    var fontFamilies = [String]()
    var fonts = [[String]]()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString("Search Font", comment: "Placeholder text for font name")
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.sizeToFit()
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let _ = FontManager.shared
        showDefaultNavigation()
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? FontDetailViewController
        }
        searchFont(byName: "")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Navigation control

    @objc func showDefaultNavigation() {
        navigationItem.titleView = nil
        navigationItem.title = NSLocalizedString("Fonts", comment: "Title for font list view")
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchNavigation(_:)))
        navigationItem.setLeftBarButtonItems([], animated: true)
        navigationItem.setRightBarButtonItems([searchButton], animated: true)
    }

    @objc func showSearchNavigation(_ sender: Any) {
        navigationItem.title = nil
        navigationItem.setLeftBarButtonItems([], animated: true)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(showDefaultNavigation))
        navigationItem.setRightBarButtonItems([cancelButton], animated: true)
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let fontName: String = fonts[indexPath.section][indexPath.row]
                let font = UIFont(name:fontName, size: UIFont.preferredFont(forTextStyle: .title1).pointSize)
                let controller = (segue.destination as! UINavigationController).topViewController as! FontDetailViewController
                controller.font = font
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fontFamilies.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fontFamilies[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)

        let fontName = fonts[indexPath.section][indexPath.row]
        cell.textLabel!.font = UIFont(name: fontName, size: UIFont.labelFontSize)
        cell.textLabel!.text = fontName
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }

    // MARK: - Search Bar

    func searchFont(byName name: String) {

        if name.isEmpty {
            fontFamilies = UIFont.familyNames
        } else {
            fontFamilies = UIFont.familyNames.filter({ (fontFamily) -> Bool in
                fontFamily.localizedCaseInsensitiveContains(name)
            })
        }

        fontFamilies.sort()
        fonts = fontFamilies.map({ (fontFamilyName) in
            return UIFont.fontNames(forFamilyName: fontFamilyName)
        })

        tableView.reloadData()

    }

}

extension FontListViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showDefaultNavigation()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFont(byName: searchText)
    }
}
