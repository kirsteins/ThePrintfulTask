import Foundation

final class CategoryTreeNode {
    let value: Category

    weak private(set) var parent: CategoryTreeNode?
    private(set) var children: [CategoryTreeNode]? = nil

    init(value: Category) {
        self.value = value
    }

    func addChild(_ node: CategoryTreeNode) {
        if children == nil {
            children = []
        }
        children?.append(node)
        node.parent = self
    }
}

extension CategoryTreeNode: CustomStringConvertible {
    var description: String {
        "Node(\(value.title))"
    }
}
