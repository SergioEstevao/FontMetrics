import SwiftUI

struct FontDetailView: UIViewControllerRepresentable {

    let font: UIFont

    func makeUIViewController(context: Context) -> FontDetailViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let fontDetailVC = storyboard.instantiateViewController(identifier: "fontDetail") as FontDetailViewController
        return fontDetailVC
    }

    func updateUIViewController(_ uiViewController: FontDetailViewController, context: Context) {
        uiViewController.font = font
    }

}

struct FontListView: View {
    @State var searchQuery: String = ""
    private let fontFamilies = UIFont.fontFamilies
    private let defaultFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)

    var body: some View {
        NavigationView {
            List {
                ForEach(fontFamilies.keys.sorted(), id: \.self) { familyName in
                    Section(header: Text(familyName)) {
                        ForEach( self.fontFamilies[familyName]!, id: \.self) { fontName in
                            NavigationLink(fontName, destination: FontDetailView(font: UIFont(name: fontName, size: UIFont.systemFontSize)!).navigationBarTitle(fontName))
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Fonts"))
            FontDetailView(font: defaultFont).navigationBarTitle(defaultFont.fontName)
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView()
    }
}
