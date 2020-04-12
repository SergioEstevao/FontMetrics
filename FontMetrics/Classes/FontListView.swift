import SwiftUI

struct FontDetailWrapperView: UIViewControllerRepresentable {

    let fontName: String

    func makeUIViewController(context: Context) -> FontDetailViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let fontDetailVC = storyboard.instantiateViewController(identifier: "fontDetail") as FontDetailViewController
        return fontDetailVC
    }

    func updateUIViewController(_ uiViewController: FontDetailViewController, context: Context) {
        uiViewController.font = UIFont(name: fontName, size: 12)!
    }

}

struct FontListView: View {
    @State var searchQuery: String = ""
    private let fontFamilies = UIFont.fontFamilies
    private let defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    @State var searchVisible: Bool = false

    private var fontSource: [String] {
        var result = fontFamilies.keys.sorted()
        if searchQuery != "" {
            result = result.filter({ (fontFamily) -> Bool in
                fontFamily.localizedCaseInsensitiveContains(searchQuery)
            })
        }
        return result
    }

    var body: some View {
        NavigationView {
            List {
                if ( searchVisible ) {
                    Section(header: Text("Search")) {
                        TextField("Search", text: $searchQuery)
                    }
                }
                ForEach(fontSource, id: \.self) { familyName in
                    Section(header: Text(familyName)) {
                        ForEach( self.fontFamilies[familyName]!, id: \.self) { fontName in
                            NavigationLink(fontName, destination: FontDetailView(
                                    fontName: fontName).navigationBarTitle(fontName))
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Fonts"))
            .navigationBarItems(trailing: Button(action: {
                self.searchVisible.toggle()
            }, label: {
                Image(systemName: "magnifyingglass")
            }))
            FontDetailView(fontName: defaultFont.fontName).navigationBarTitle(defaultFont.fontName)
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView()
    }
}