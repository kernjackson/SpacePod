import SwiftUI

struct PodImageView: View {
    var url: URL?
    var body: some View {
        if url != nil {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:                ProgressView()
            case .success(let image):   ImageRowView(image: image)
            case .failure(_):           ErrorView()
            @unknown default:           EmptyView()
            }
        }
        }
    }
}

struct PodImageView_Previews: PreviewProvider {
    static var url = File.data(from: "get-pod", withExtension: .json)?.toPod?.url
    static var thumbnailUrl = File.data(from: "get-video", withExtension: .json)?.toPod?.thumbnailUrl
    static var previews: some View {
        List {
            Section("image") {
                PodImageView(url: url!)
            }
            Section("video") {
                PodImageView(url: thumbnailUrl!)
            }
        }
    }
}
