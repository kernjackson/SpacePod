# SpacePod 20 Video Thumbnails

[YouTube](https://youtu.be/re2bBrFOw5Q)

## Problem

Some PODs don't display an image. Sometimes there's nothing to show, but typically it means the "Picture Of the Day" is something else like a video. Fortunately The API can optionally return a thumbnail image. Unfortunately we have to do a little work to know when to use what.

## 

1. Update Network to return video thumbnails
2. Display image at `thumbnailUrl` if available
3. Otherwise display image at `url`
4. Update preview to display both

### Network.swift

```swift
let count = "&count=20"
    let thumbs = "&thumbs=true"

    func getPods() async -> [Pod]? {
        let url = URL(string: "\(baseUrl)\(apiKey)\(count)\(thumbs)")!
```


### PodDetailView.swift

```swift
struct PodDetailView: View {
    @State var pod: Pod
    var body: some View {
        List {
            if let url = pod.thumbnailUrl ?? pod.url {
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
```

### PodImageView.swift

```swift
struct PodDetailView_Previews: PreviewProvider {
    static var imagePod = File.data(from: "get-pod", withExtension: .json)?.toPod?.url
    static var videoPod = File.data(from: "get-video", withExtension: .json)?.toPod?.thumbnailUrl
    static var previews: some View {
        List {
            Section("image") {
                PodImageView(url: imagePod!)
            }
            Section("video") {
                PodImageView(url: videoPod!)
            }
        }
    }
}
```
