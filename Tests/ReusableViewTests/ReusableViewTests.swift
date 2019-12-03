#if os(iOS)
import XCTest
@testable import ReusableView

final class ReusableViewTests: XCTestCase {

    func testTableView() {
        let height: CGFloat = 44
        let data = ["one", "two", "three", "four"]
        let frame =  CGRect(x: 0, y: 0, width: 100, height: height * CGFloat(data.count))
        let tableView = UITableView(frame: frame, style: .plain)
        tableView.rv.register(ReusableSubview.self)
        let dataSource = TableViewDataSource(data: data, height: height)
        tableView.dataSource = dataSource
        tableView.reloadData()

        tableView.visibleCells.enumerated().forEach { args in
            let (offset, cell) = args
            do {
                let cell = try XCTUnwrap(cell as? TableViewCell<ReusableSubview>)
                XCTAssertEqual(cell.view.title, data[offset])
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        data.enumerated().forEach { args in
            let (offset, element) = args
            let indexPath = IndexPath(row: offset, section: 0)
            do {
                let cell = try XCTUnwrap(tableView.rv.cell(ReusableSubview.self, forRowAt: indexPath))
                XCTAssertEqual(cell.view.title, element)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testCollectionView() {
        let size = CGSize(width: 100, height: 44)
        let data = ["one", "two", "three", "four"]
        let frame =  CGRect(x: 0, y: 0, width: size.width, height: size.height * CGFloat(data.count))
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.rv.register(ReusableSubview.self)
        let dataSource = CollectionViewDataSource(data: data)
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        collectionView.layoutIfNeeded()

        collectionView.visibleCells.enumerated().forEach { args in
            let (offset, cell) = args
            do {
                let cell = try XCTUnwrap(cell as? CollectionViewCell<ReusableSubview>)
                XCTAssertEqual(cell.view.title, data[offset])
            } catch {
                XCTFail(error.localizedDescription)
            }
        }

        data.enumerated().forEach { args in
            let (offset, element) = args
            let indexPath = IndexPath(item: offset, section: 0)
            do {
                let cell = try XCTUnwrap(collectionView.rv.cell(ReusableSubview.self, forItemAt: indexPath))
                XCTAssertEqual(cell.view.title, element)
            } catch {
                XCTFail(error.localizedDescription)
            }
        }
    }

    static var allTests = [
        ("testTableView", testTableView),
        ("testCollectionView", testCollectionView)
    ]
}

extension ReusableViewTests {

    private class ReusableSubview: ReusableView {

        var title: String?

        required override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func prepareForReuse() {}
    }

    private class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

        private let data: [String]
        private let height: CGFloat

        init(data: [String], height: CGFloat) {
            self.data = data
            self.height = height
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.rv.dequeue(ReusableSubview.self, for: indexPath)
            cell.view.title = data[indexPath.row]
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return height
        }
    }

    private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

        private let data: [String]

        init(data: [String]) {
            self.data = data
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return data.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.rv.dequeue(ReusableSubview.self, for: indexPath)
            cell.view.title = data[indexPath.item]
            return cell
        }
    }
}
#endif
