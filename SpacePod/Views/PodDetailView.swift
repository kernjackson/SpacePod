import SwiftUI

struct PodDetailView: View {
    @State var pod: Pod
    var body: some View {
        List {
            if let url = pod.url {
                PodImageView(url: url)
            }
            Text(pod.title)
                .font(.title)
                .bold()
                .padding(.vertical)
            if let copyright = pod.copyright {
                Label(copyright, systemImage: "c.circle.fill")
            }
            if let date = pod.date {
                Label(date.long, systemImage: "calendar")
            }
            Text(pod.explanation)
                .padding(.vertical)
        }
    }
}

struct PodDetailView_Previews: PreviewProvider {
    static var pod = File.data(from: "get-pod", withExtension: .json)?.toPod
    static var previews: some View {
        PodDetailView(pod: pod!)
    }
}
