import XCTest
@testable import SpacePod

class SpacePodTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: Decoding Pod(s)

    func testLoadPodFromFile() {
        let pod = File.data(from: "get-pod", withExtension: .json)?.toPod
        XCTAssertEqual(pod, Pod.default, "Pod from file matches default Pod.")
    }

    func testLoadPodFromNoCopyright() {
        let pod = File.data(from: "200-no-copyright", withExtension: .json)?.toPod
        XCTAssertNotNil(pod)
        XCTAssertNil(pod?.copyright)
    }

    func testDecodePodEmptyExplanation() {
        let pod = File.data(from: "200-empty-explanation", withExtension: .json)?.toPod
        XCTAssertNotNil(pod)
        XCTAssertNotNil(pod?.explanation)
        XCTAssertEqual(pod?.explanation, "")
    }

    func testDecodePodWithNoHDURL() {
        let pod = File.data(from: "get-video", withExtension: .json)?.toPod
        XCTAssertNotNil(pod)
        XCTAssertNil(pod?.hdurl)
    }

    func testDecodePodWithThumbnailURL() {
        let pod = File.data(from: "get-video", withExtension: .json)?.toPod
        XCTAssertNotNil(pod)
        XCTAssertEqual(pod?.thumbnailUrl?.absoluteString, "https://img.youtube.com/vi/7NykS2kv_k8/0.jpg")
    }

    func testDecodePods() {
        let pods = File.data(from: "get-pods", withExtension: .json)?.toPods
        XCTAssertNotNil(pods)
        XCTAssertEqual(pods?.count, 2, "")
    }

    func testDecodePodNoURL() {
        let pod = File.data(from: "200-no-urls", withExtension: .json)?.toPod
        XCTAssertEqual(pod?.title, "Falling to Earth")
        XCTAssertNil(pod?.url)
    }
}
