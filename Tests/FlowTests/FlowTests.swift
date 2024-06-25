import SwiftUI
import XCTest
@testable import Flow

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
final class FlowTests: XCTestCase {
    func test_HFlow_size_singleElement() throws {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 10, lineSpacing: 20)

        // When
        let size = sut.sizeThatFits(proposal: 100×100, subviews: [50×50])

        // Then
        XCTAssertEqual(size, 50×50)
    }

    func test_HFlow_size_multipleElements() throws {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 10, lineSpacing: 20)

        // When
        let size = sut.sizeThatFits(proposal: 130×130, subviews: repeated(50×50, times: 3))

        // Then
        XCTAssertEqual(size, 110×120)
    }

    func test_HFlow_layout_top() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .top, itemSpacing: 1, lineSpacing: 1)
        
        // When
        let result = sut.layout([5×1, 5×3, 5×1, 5×1], in: 20×6)

        // Then
        XCTAssertEqual(render(result), """
        +--------------------+
        |XXXXX XXXXX XXXXX   |
        |      XXXXX         |
        |      XXXXX         |
        |                    |
        |XXXXX               |
        |                    |
        +--------------------+
        """)
    }

    func test_HFlow_layout_center() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 1)

        // When
        let result = sut.layout([5×1, 5×3, 5×1, 5×1], in: 20×6)

        // Then
        XCTAssertEqual(render(result), """
        +--------------------+
        |      XXXXX         |
        |XXXXX XXXXX XXXXX   |
        |      XXXXX         |
        |                    |
        |XXXXX               |
        |                    |
        +--------------------+
        """)
    }

    func test_HFlow_layout_bottom() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .bottom, itemSpacing: 1, lineSpacing: 1)

        // When
        let result = sut.layout([5×1, 5×3, 5×1, 5×1], in: 20×6)

        // Then
        XCTAssertEqual(render(result), """
        +--------------------+
        |      XXXXX         |
        |      XXXXX         |
        |XXXXX XXXXX XXXXX   |
        |                    |
        |XXXXX               |
        |                    |
        +--------------------+
        """)
    }

    func test_HFlow_layout() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0)

        // When
        let result = sut.layout(repeated(1×1, times: 15), in: 11×3)

        // Then
        XCTAssertEqual(render(result), """
        +-----------+
        |X X X X X X|
        |X X X X X X|
        |X X X      |
        +-----------+
        """)
    }

    func test_VFlow_layout_leading() {
        // Given
        let sut: FlowLayout = .vertical(alignment: .leading, itemSpacing: 1, lineSpacing: 1)

        // When
        let result = sut.layout([1×1, 3×1, 1×1, 1×1, 1×1], in: 5×5)

        // Then
        XCTAssertEqual(render(result), """
        +-----+
        |X   X|
        |     |
        |XXX X|
        |     |
        |X    |
        +-----+
        """)
    }
    func test_VFlow_layout_center() {
        // Given
        let sut: FlowLayout = .vertical(alignment: .center, itemSpacing: 1, lineSpacing: 1)

        // When
        let result = sut.layout([1×1, 3×1, 1×1, 1×1, 1×1], in: 5×5)

        // Then
        XCTAssertEqual(render(result), """
        +-----+
        | X  X|
        |     |
        |XXX X|
        |     |
        | X   |
        +-----+
        """)
    }

    func test_VFlow_layout_trailing() {
        // Given
        let sut: FlowLayout = .vertical(alignment: .trailing, itemSpacing: 1, lineSpacing: 1)

        // When
        let result = sut.layout([1×1, 3×1, 1×1, 1×1, 1×1], in: 5×5)

        // Then
        XCTAssertEqual(render(result), """
        +-----+
        |  X X|
        |     |
        |XXX X|
        |     |
        |  X  |
        +-----+
        """)
    }

    func test_VFlow_layout() {
        // Given
        let sut: FlowLayout = .vertical(alignment: .center, itemSpacing: 0, lineSpacing: 0)

        // When
        let result = sut.layout(repeated(1×1, times: 17), in: 6×3)

        // Then
        XCTAssertEqual(render(result), """
        +------+
        |XXXXXX|
        |XXXXXX|
        |XXXXX |
        +------+
        """)
    }

    func test_HFlow_justifiedSpaces_rigid() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchSpaces)

        // When
        let result = sut.layout([3×1, 3×1, 2×1], in: 9×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXX   XXX|
        |XX       |
        +---------+
        """)
    }

    func test_HFlow_justifiedSpaces_flexible() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchSpaces)

        // When
        let result = sut.layout([3×1, 3×1...inf×1, 2×1], in: 9×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXX   XXX|
        |XX       |
        +---------+
        """)
    }

    func test_HFlow_justifiedItems_rigid() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchItems)

        // When
        let result = sut.layout([3×1, 3×1, 2×1], in: 9×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXX XXX  |
        |XX       |
        +---------+
        """)
    }

    func test_HFlow_justifiedItems_flexible() {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchItems)

        // When
        let result = sut.layout([3×1...4×1, 3×1...inf×1, 2×1...5×1], in: 9×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXXX XXXX|
        |XXXXX    |
        +---------+
        """)
    }

    func test_HFlow_justifiedItemsAndSpaces_rigid() throws {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchItemsAndSpaces)

        // When
        let result = sut.layout([1×1, 2×1...5×1, 1×1...inf×1, 2×1], in: 10×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXX   XXX|
        |XX       |
        +---------+
        """)
    }

    func test_HFlow_justifiedItemsAndSpaces_flexible() throws {
        // Given
        let sut: FlowLayout = .horizontal(alignment: .center, itemSpacing: 1, lineSpacing: 0, justification: .stretchItemsAndSpaces)

        // When
        let result = sut.layout([1×1, 2×1...5×1, 1×1...inf×1, 2×1], in: 10×2)

        // Then
        XCTAssertEqual(render(result), """
        +---------+
        |XXX   XXX|
        |XX       |
        +---------+
        """)
    }
}

private typealias LayoutDescription = (subviews: [TestSubview], reportedSize: CGSize)

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private extension FlowLayout {
    func layout(_ subviews: [TestSubview], in bounds: CGSize) -> LayoutDescription {
        let size = sizeThatFits(
            proposal: ProposedViewSize(width: bounds.width, height: bounds.height),
            subviews: subviews
        )
        placeSubviews(
            in: CGRect(origin: .zero, size: bounds),
            proposal: ProposedViewSize(width: size.width, height: size.height),
            subviews: subviews
        )
        return (subviews, bounds)
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private func render(_ layout: LayoutDescription, border: Bool = true) -> String {
    struct Point: Hashable {
        let x, y: Int
    }

    var positions: Set<Point> = []
    for view in layout.subviews {
        if let placement = view.placement {
            let point = placement.position
            for y in Int(point.y) ..< Int(point.y + placement.size.height) {
                for x in Int(point.x) ..< Int(point.x + placement.size.width) {
                    let result = positions.insert(Point(x: x, y: y))
                    precondition(result.inserted, "Boxes should not overlap")
                }
            }
        } else {
            fatalError("Should be placed")
        }
    }
    let width = Int(layout.reportedSize.width)
    let height = Int(layout.reportedSize.height)
    var result = ""
    if border {
        result += "+" + String(repeating: "-", count: width) + "+\n"
    }
    for y in 0 ... height - 1 {
        if border {
            result += "|"
        }
        for x in 0 ... width - 1 {
            result += positions.contains(Point(x: x, y: y)) ? "X" : " "
        }
        if border {
            result += "|"
        } else {
            result = result.trimmingCharacters(in: .whitespaces)
        }
        result += "\n"
    }
    if border {
        result += "+" + String(repeating: "-", count: width) + "+\n"
    }
    return result.trimmingCharacters(in: .newlines)
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
private final class TestSubview: Subview, CustomStringConvertible {
    var spacing = ViewSpacing()
    var priority: Double = 1
    var placement: (position: CGPoint, size: CGSize)?
    var minSize: CGSize
    var idealSize: CGSize
    var maxSize: CGSize

    init(size: CGSize) {
        minSize = size
        idealSize = size
        maxSize = size
    }

    init(minSize: CGSize, idealSize: CGSize, maxSize: CGSize) {
        self.minSize = minSize
        self.idealSize = idealSize
        self.maxSize = maxSize
    }

    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize {
        switch proposal {
            case .zero:
                minSize
            case .unspecified:
                idealSize
            case .infinity:
                maxSize
            default:
                CGSize(
                    width: min(max(minSize.width, proposal.width ?? idealSize.width), maxSize.width),
                    height: min(max(minSize.height, proposal.height ?? idealSize.height), maxSize.height)
                )
        }
    }

    func dimensions(_ proposal: ProposedViewSize) -> Dimensions {
        let size = switch proposal {
            case .zero:  minSize
            case .unspecified: idealSize
            case .infinity: maxSize
            default: sizeThatFits(proposal)
        }
        return TestDimensions(width: size.width, height: size.height)
    }

    func place(at position: CGPoint, anchor: UnitPoint, proposal: ProposedViewSize) {
        let size = sizeThatFits(proposal)
        placement = (position, size)
    }

    var description: String {
        "origin: \((placement?.position.x).map { "\($0)" } ?? "nil")×\((placement?.position.y).map { "\($0)" } ?? "nil"), size: \(idealSize.width)×\(idealSize.height)"
    }
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension [TestSubview]: Subviews {}

private struct TestDimensions: Dimensions {
    let width, height: CGFloat

    subscript(guide: HorizontalAlignment) -> CGFloat {
        switch guide {
            case .center: 0.5 * width
            case .trailing: width
            default: 0
        }
    }

    subscript(guide: VerticalAlignment) -> CGFloat {
        switch guide {
            case .center: 0.5 * height
            case .bottom: height
            default: 0
        }
    }
}

infix operator ×: MultiplicationPrecedence

private func × (lhs: CGFloat, rhs: CGFloat) -> CGSize {
    CGSize(width: lhs, height: rhs)
}

private func × (lhs: CGFloat, rhs: CGFloat) -> TestSubview {
    .init(size: .init(width: lhs, height: rhs))
}

private func × (lhs: CGFloat, rhs: CGFloat) -> ProposedViewSize {
    .init(width: lhs, height: rhs)
}

infix operator ...: RangeFormationPrecedence

private func ... (lhs: CGSize, rhs: CGSize) -> TestSubview {
    TestSubview(minSize: lhs, idealSize: lhs, maxSize: rhs)
}

private func repeated<T>(_ factory: @autoclosure () -> T, times: Int) -> [T] {
    (1...times).map { _ in factory() }
}

let inf: CGFloat = .infinity
