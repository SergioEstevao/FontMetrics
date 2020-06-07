import SwiftUI

struct FontListView: View {
    @State var searchQuery: String = ""
    @ObservedObject var fontManager = FontManager.shared
    @State var searchVisible: Bool = false

    private var fontSource: [String] {
        var result = fontManager.fontFamilies.keys.sorted()
        if !searchQuery.trimmingCharacters(in: .whitespaces).isEmpty {
            result = result.filter({ (fontFamily) -> Bool in
                fontFamily.localizedCaseInsensitiveContains(searchQuery)
            })
        }
        return result
    }

    private var defaultFontName: String {
        guard let name = fontManager.fontFamilies.keys.sorted().first else {
            return ""
        }
        return fontManager.fontFamilies[name]![0]
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
                        ForEach( self.fontManager.fontFamilies[familyName]!, id: \.self) { fontName in
                            NavigationLink(fontName, destination: FontDetailView(
                                fontName: fontName).navigationBarTitle(fontName))
                        }
                    }
                }
            }
            .modifier(AdaptsToSoftwareKeyboard())
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
