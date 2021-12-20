import SwiftUI

struct ErrorView: View {
    var body: some View {
        Label {
            Text("Error fetching image")
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
