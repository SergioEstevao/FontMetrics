import XCTest

class FontMetricsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainFlow() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        let tablesQuery = app.tables
        snapshot("0List")
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["AmericanTypewriter"]/*[[".cells.buttons[\"AmericanTypewriter\"]",".buttons[\"AmericanTypewriter\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery.cells.otherElements.containing(.staticText, identifier:"Descender:").images["square.fill"].tap()
        snapshot("1Detail")
        app.navigationBars["AmericanTypewriter"].buttons["Fonts"].tap()
        
    }
    
}
