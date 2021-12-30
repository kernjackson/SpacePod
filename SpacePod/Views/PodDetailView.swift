import SwiftUI

struct PodDetailView: View {
    @State var pod: Pod
    var body: some View {
        List {
            if let url = pod.thumbnailUrl ?? pod.url {
                PodImageView(url: url)
            }
            if let title = pod.title {
                Text(title)
                    .font(.title)
                    .bold()
                    .padding(.vertical)
            }
            if let copyright = pod.copyright {
                Label(copyright, systemImage: "c.circle.fill")
            }
            if let date = pod.date {
                Label(date.long, systemImage: "calendar")
            }
            if let explanation = pod.explanation {
                Text(explanation)
                    .padding(.vertical)
            }
        }
    }
}

struct PodDetailView_Previews: PreviewProvider {
    static var pod = File.data(from: "get-pod", withExtension: .json)?.toPod
    static var previews: some View {
        PodDetailView(pod: pod!)
    }
}
