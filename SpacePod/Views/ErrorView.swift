import SwiftUI

struct ErrorView: View {

    var description: String

    var body: some View {
        Label {
            Text(description)
        } icon: {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(description: "Error Description")
    }
}
