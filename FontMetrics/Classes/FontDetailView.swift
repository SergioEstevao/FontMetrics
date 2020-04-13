import SwiftUI

struct FontMetricRowView: View {
    let label: String
    let value: CGFloat
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: "square.fill").foregroundColor(color)
            Text(label)
            Spacer()
            Text("\(value as NSNumber, formatter: Style.metricFormatter)")
                .font(Font.body.monospacedDigit())
        }
    }
}

struct FontDetailView: View {

    let fontName: String
    var content: State<String>
    var size: State<Float>
    var font: State<UIFont>

    init(fontName: String) {
        self.fontName = fontName
        content = State(initialValue: "Metrics")
        size = State(initialValue: 24)
        font = State(initialValue: UIFont(name: fontName, size: CGFloat(size.wrappedValue))!)
    }

    var body: some View {
        Form {
            Section(header: Text("Preview")) {
                HStack {
                    Spacer()
                    FontMetricsTextView(placeholder: "Metrics", text: content.wrappedValue ).font(font.projectedValue)
                    Spacer()
                }
            }
            Section(header: Text("Size")) {
                VStack {
                    Slider(value: size.projectedValue, in: 10...60, step: 1, onEditingChanged: { changing  in
                        self.font.wrappedValue = UIFont(name: self.fontName, size: CGFloat(self.size.wrappedValue))!
                        })
                    Text("\(Int(size.wrappedValue))pt")
                }
            }
            Section(header: Text("Metrics")) {
                FontMetricRowView(label: "Size:", value: font.wrappedValue.pointSize, color: .clear)
                FontMetricRowView(label: "Line Height:", value: font.wrappedValue.lineHeight, color: .clear)
                FontMetricRowView(label: "Ascender:", value: font.wrappedValue.ascender, color: .red)
                FontMetricRowView(label: "Descender:", value: font.wrappedValue.descender, color: .green)
                FontMetricRowView(label: "Cap Height:", value: font.wrappedValue.capHeight, color: .purple)
                FontMetricRowView(label: "x Height:", value: font.wrappedValue.xHeight, color: .blue)
            }
        }
    }
}

struct FontDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FontDetailView(fontName: UIFont.systemFont(ofSize: 10).fontName)
    }
}
