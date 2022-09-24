import XCTest
@testable import ThePrintfulTask

final class ThePrintfulTaskTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCategoryTreeBuilder() {
        let mens = Category(id: 1, parentId: 0, imageURL: "", title: "Men\'s clothing")
        let womens = Category(id: 2, parentId: 0, imageURL: "", title: "Women\'s clothing")

        let allShirts = Category(id: 6, parentId: 1, imageURL: "", title: "All shirts")

        let shirts1 = Category(id: 23, parentId: 6, imageURL: "", title: "Tank tops")
        let shirts2 = Category(id: 24, parentId: 6, imageURL: "", title: "T-shirts")
        let shirts3 = Category(id: 25, parentId: 6, imageURL: "", title: "3/4 sleeve shirts")
        let shirts4 = Category(id: 26, parentId: 6, imageURL: "", title: "Long sleeve shirts")
        let shirts5 = Category(id: 27, parentId: 6, imageURL: "", title: "All-over shirts")

        let dresses = Category(id: 11, parentId: 2, imageURL: "", title: "Dresses")

        let categories: [ThePrintfulTask.Category] = [
            mens,
            womens,
            allShirts,
            shirts1,
            shirts2,
            shirts3,
            shirts4,
            shirts5,
            dresses,
        ]

        let mainTreeNodes = makeTree(fromCategories: categories)

        XCTAssertTrue(mainTreeNodes.count == 2)
        XCTAssertEqual(mainTreeNodes[0].value, mens)
        XCTAssertEqual(mainTreeNodes[1].value, womens)

        let menNode = mainTreeNodes[0]
        let womenNode = mainTreeNodes[1]

        XCTAssertTrue(menNode.children?.count == 1)
        XCTAssertEqual(menNode.children?.first?.value, allShirts)

        let shirtNode = menNode.children?.first

        XCTAssertTrue(shirtNode?.children?.count == 5)
        XCTAssertEqual(shirtNode?.children?.first?.value, shirts1)
        XCTAssertEqual(shirtNode?.children?.last?.value, shirts5)

        XCTAssertTrue(womenNode.children?.count == 1)
        XCTAssertEqual(womenNode.children?.first?.value, dresses)
    }
}
