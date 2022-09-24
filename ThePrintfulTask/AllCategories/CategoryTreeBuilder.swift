import Foundation

func makeTree(fromCategories categories: [Category]) -> [CategoryTreeNode] {
    let categoriesByParentId = Dictionary(grouping: categories, by: { $0.parentId })

    let rootCategories = categoriesByParentId[0] ?? []
    let rootNodes = rootCategories.map {
        CategoryTreeNode(value: $0)
    }

    for node in rootNodes {
        assignChildrenRecursively(node: node, categoriesByParentId: categoriesByParentId)
    }

    return rootNodes
}

private func assignChildrenRecursively(
    node: CategoryTreeNode,
    categoriesByParentId: [Int : [Category]]
) {
    let categories = categoriesByParentId[node.value.id] ?? []
    for category in categories {
        let childNode = CategoryTreeNode(value: category)
        node.addChild(childNode)
        assignChildrenRecursively(node: childNode, categoriesByParentId: categoriesByParentId)
    }
}
