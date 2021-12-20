import SwiftUI

struct ImageRowView: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .listRowInsets(.init())
            .listRowSeparator(.hidden)
    }
}

struct ImageRowView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ImageRowView(image: Image(systemName: "photo.fill"))
        }
    }
}
