import SwiftUI

struct PodDetailView: View {
    @State var pod: Pod
    var body: some View {
        List {
            AsyncImage(url: pod.url)
                .frame(height: 280)
                .listRowInsets(.init())
            Text(pod.title)
                .font(.title)
                .bold()
                .padding(.vertical)
            if let copyright = pod.copyright {
                Label(copyright, systemImage: "c.circle.fill")
            }
            Label(pod.date, systemImage: "calendar")
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
