import SwiftUI

struct FontListView: View {
    @State var searchQuery: String = ""
    private let fontFamilies = UIFont.fontFamilies
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

    private var defaultFontName: String {
        return fontFamilies[fontSource[0]]![0]
    }

    var body: some View {
        NavigationView {
            List {
                if searchVisible {
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
            FontDetailView(fontName: defaultFontName).navigationBarTitle(defaultFontName)
        }
    }
}

struct FontListView_Previews: PreviewProvider {
    static var previews: some View {
        FontListView()
    }
}
