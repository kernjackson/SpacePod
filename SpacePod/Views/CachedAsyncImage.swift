import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    @State var image: UIImage?

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = FileManager.loadImage(name: url.lastPathComponent) ?? image {
            content(.success(Image(uiImage: cached)))
                .animation(transaction.animation, value: cached)
        } else {
            content(.empty)
                .task {
                    image = await Network.shared.getImage(url: url)
                    image?.saveJPG(name: url.lastPathComponent)
                }
        }
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {

    static let url = URL(string: "https://apod.nasa.gov/apod/image/2112/JwstLaunch_Arianespace_1080.jpg")!

    static var previews: some View {
        CachedAsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
            case .failure(let error):
                ErrorView(description: error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
    }
}
