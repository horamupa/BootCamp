//
//  UnitTestingBootcampViewModel_Tests.swift
//  BootCamp_Tests
//
//  Created by MM on 09.01.2023.
//

import XCTest
@testable import BootCamp

// Naming structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming structure: test_[struct or class]_[variable or function inside ]_[expected result]
// Testing Structure: Given, When, Then

final class UnitTestingBootcampViewModel_Tests: XCTestCase {
    
    var viewModel: UnitTestingBootcampViewModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        viewModel = UnitTestingBootcampViewModel(isPremium: Bool.random())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil 
    }

    func test_UnitTestingBootcampViewModel_isPremium_shouldBeTrue() {
        //Given
        let isPremium: Bool = true
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: isPremium)
        
        //Then
        XCTAssertTrue(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeFalse() {
        //Given
        let isPremium: Bool = false
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: isPremium)
        
        //Then
        XCTAssertFalse(vm.isPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue() {
        //Given
        let userIsPremium: Bool = Bool.random()
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: userIsPremium)
        
        //Then
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            test_UnitTestingBootcampViewModel_isPremium_shouldBeInjectedValue()
        }
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldBeEmpty() {
        //Given
        
        //When
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldAddItem() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let count = vm.dataArray.count
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        //Then
        XCTAssertTrue(!vm.dataArray.isEmpty)
        XCTAssertFalse(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, loopCount)
        XCTAssertNotEqual(vm.dataArray.count , 0)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        //XCTAssertLessThan
        //XCTAssertGreaterThanOrEqual()
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlancString() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let count = vm.dataArray.count
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_dataArray_shouldNotAddBlancString2() {
        //Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        //When
        let count = vm.dataArray.count
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldStartAsNil() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        
        vm.addItem(item: "")
        
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeNilWhenSelectedInvalidItem() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
       
        //When
        //select valid item
        let newItem: String = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(name: newItem)
        
        //select invalid item
        vm.selectItem(name: UUID().uuidString)
        
        //Then
        XCTAssertTrue(vm.selectedItem == nil)
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let newItem: String = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectItem(name: newItem)

        //Then
        XCTAssertTrue(vm.selectedItem != nil)
        XCTAssertTrue(vm.selectedItem == newItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingBootcampViewModel_selectedItem_shouldBeSelected_stress() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem: String = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        
        vm.selectItem(name: randomItem)

        //Then
        XCTAssertTrue(vm.selectedItem != nil)
        XCTAssertTrue(vm.selectedItem == randomItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_itemNotFound() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            let newItem: String = UUID().uuidString
            vm.addItem(item: newItem)
        }
        
        let item = UUID().uuidString
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: item))
        
        XCTAssertThrowsError(try vm.saveItem(item: item), "Should throw item no found") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.itemNoFound)
        }
    }
    
    func test_UnitTestingBootcampViewModel_saveItem_shouldThrowError_noData() {
        //Given
        let vm = UnitTestingBootcampViewModel(isPremium: Bool.random())
        //When
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        let item = UUID().uuidString
        
        //Then
        XCTAssertThrowsError(try vm.saveItem(item: ""))
        
        XCTAssertThrowsError(try vm.saveItem(item: ""), "Should throw noData") { error in
            let returnedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingBootcampViewModel.DataError.noData)
        }
        /* or
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let catchedError = error as? UnitTestingBootcampViewModel.DataError
            XCTAssertEqual(catchedError, UnitTestingBootcampViewModel.DataError.noData)
        }
         */
    }
    
//    func test_UnitTestingBootcampViewModel_saveItem_shouldSaveItem() {
//        //Given
//        let vm = UnitTestingBootcampViewModel(isPremium: true)
//
//        //When
//        let loopCount: Int = Int.random(in: 1..<100)
//        var itemsArray: [String] = []
//
//        for _ in 0..<loopCount {
//            let newItem: String = UUID().uuidString
//            vm.addItem(item: newItem)
//            itemsArray.append(newItem)
//        }
//
//        let randomItem = itemsArray.randomElement() ?? ""
//        XCTAssertTrue(!randomItem.isEmpty)
//
//        //Then
//        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
//
//        do {
//            try vm.saveItem(item: randomItem)
//        } catch  {
//            XCTFail()
//        }
//    }
    

}
