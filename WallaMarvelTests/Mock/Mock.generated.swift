// Generated using Sourcery 1.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.2.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Foundation
@testable import WallaMarvel


// MARK: - CharactersRemoteDataSource

open class CharactersRemoteDataSourceMock: CharactersRemoteDataSource, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCharacters(offset: Int, limit: Int, searchText: String) throws -> CharacterDataContainerEntity {
        addInvocation(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`)))
		let perform = methodPerformValue(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))) as? (Int, Int, String) -> Void
		perform?(`offset`, `limit`, `searchText`)
		var __value: CharacterDataContainerEntity
		do {
		    __value = try methodReturnValue(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for getCharacters(offset: Int, limit: Int, searchText: String). Use given")
			Failure("Stub return value not specified for getCharacters(offset: Int, limit: Int, searchText: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func getCharacterComics(characterId: Int, offset: Int, limit: Int) throws -> ComicDataContainerEntity {
        addInvocation(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`)))
		let perform = methodPerformValue(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))) as? (Int, Int, Int) -> Void
		perform?(`characterId`, `offset`, `limit`)
		var __value: ComicDataContainerEntity
		do {
		    __value = try methodReturnValue(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for getCharacterComics(characterId: Int, offset: Int, limit: Int). Use given")
			Failure("Stub return value not specified for getCharacterComics(characterId: Int, offset: Int, limit: Int). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>, Parameter<Int>, Parameter<String>)
        case m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>, Parameter<Int>, Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(let lhsOffset, let lhsLimit, let lhsSearchtext), .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(let rhsOffset, let rhsLimit, let rhsSearchtext)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher), lhsSearchtext, rhsSearchtext, "searchText"))
				return Matcher.ComparisonResult(results)

            case (.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(let lhsCharacterid, let lhsOffset, let lhsLimit), .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(let rhsCharacterid, let rhsOffset, let rhsLimit)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCharacterid, rhs: rhsCharacterid, with: matcher), lhsCharacterid, rhsCharacterid, "characterId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCharacters__offset_offsetlimit_limitsearchText_searchText: return ".getCharacters(offset:limit:searchText:)"
            case .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit: return ".getCharacterComics(characterId:offset:limit:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willReturn: CharacterDataContainerEntity...) -> MethodStub {
            return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willReturn: ComicDataContainerEntity...) -> MethodStub {
            return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willProduce: (StubberThrows<CharacterDataContainerEntity>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (CharacterDataContainerEntity).self)
			willProduce(stubber)
			return given
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willProduce: (StubberThrows<ComicDataContainerEntity>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (ComicDataContainerEntity).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>) -> Verify { return Verify(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`))}
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>) -> Verify { return Verify(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, perform: @escaping (Int, Int, String) -> Void) -> Perform {
            return Perform(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), performs: perform)
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, perform: @escaping (Int, Int, Int) -> Void) -> Perform {
            return Perform(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - CharactersRepository

open class CharactersRepositoryMock: CharactersRepository, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getCharacters(offset: Int, limit: Int, searchText: String) throws -> CharacterDataContainerEntity {
        addInvocation(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`)))
		let perform = methodPerformValue(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))) as? (Int, Int, String) -> Void
		perform?(`offset`, `limit`, `searchText`)
		var __value: CharacterDataContainerEntity
		do {
		    __value = try methodReturnValue(.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for getCharacters(offset: Int, limit: Int, searchText: String). Use given")
			Failure("Stub return value not specified for getCharacters(offset: Int, limit: Int, searchText: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func getCharacterComics(characterId: Int, offset: Int, limit: Int) throws -> ComicDataContainerEntity {
        addInvocation(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`)))
		let perform = methodPerformValue(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))) as? (Int, Int, Int) -> Void
		perform?(`characterId`, `offset`, `limit`)
		var __value: ComicDataContainerEntity
		do {
		    __value = try methodReturnValue(.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for getCharacterComics(characterId: Int, offset: Int, limit: Int). Use given")
			Failure("Stub return value not specified for getCharacterComics(characterId: Int, offset: Int, limit: Int). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getCharacters__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>, Parameter<Int>, Parameter<String>)
        case m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>, Parameter<Int>, Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCharacters__offset_offsetlimit_limitsearchText_searchText(let lhsOffset, let lhsLimit, let lhsSearchtext), .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(let rhsOffset, let rhsLimit, let rhsSearchtext)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher), lhsSearchtext, rhsSearchtext, "searchText"))
				return Matcher.ComparisonResult(results)

            case (.m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(let lhsCharacterid, let lhsOffset, let lhsLimit), .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(let rhsCharacterid, let rhsOffset, let rhsLimit)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCharacterid, rhs: rhsCharacterid, with: matcher), lhsCharacterid, rhsCharacterid, "characterId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCharacters__offset_offsetlimit_limitsearchText_searchText: return ".getCharacters(offset:limit:searchText:)"
            case .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit: return ".getCharacterComics(characterId:offset:limit:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willReturn: CharacterDataContainerEntity...) -> MethodStub {
            return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willReturn: ComicDataContainerEntity...) -> MethodStub {
            return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willProduce: (StubberThrows<CharacterDataContainerEntity>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (CharacterDataContainerEntity).self)
			willProduce(stubber)
			return given
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willProduce: (StubberThrows<ComicDataContainerEntity>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (ComicDataContainerEntity).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>) -> Verify { return Verify(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`))}
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>) -> Verify { return Verify(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCharacters(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, perform: @escaping (Int, Int, String) -> Void) -> Perform {
            return Perform(method: .m_getCharacters__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), performs: perform)
        }
        public static func getCharacterComics(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, perform: @escaping (Int, Int, Int) -> Void) -> Perform {
            return Perform(method: .m_getCharacterComics__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GetCharacterComicsUseCase

open class GetCharacterComicsUseCaseMock: GetCharacterComicsUseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(characterId: Int, offset: Int, limit: Int) throws -> ComicsPage {
        addInvocation(.m_execute__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`)))
		let perform = methodPerformValue(.m_execute__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))) as? (Int, Int, Int) -> Void
		perform?(`characterId`, `offset`, `limit`)
		var __value: ComicsPage
		do {
		    __value = try methodReturnValue(.m_execute__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>.value(`characterId`), Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for execute(characterId: Int, offset: Int, limit: Int). Use given")
			Failure("Stub return value not specified for execute(characterId: Int, offset: Int, limit: Int). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__characterId_characterIdoffset_offsetlimit_limit(Parameter<Int>, Parameter<Int>, Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__characterId_characterIdoffset_offsetlimit_limit(let lhsCharacterid, let lhsOffset, let lhsLimit), .m_execute__characterId_characterIdoffset_offsetlimit_limit(let rhsCharacterid, let rhsOffset, let rhsLimit)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCharacterid, rhs: rhsCharacterid, with: matcher), lhsCharacterid, rhsCharacterid, "characterId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__characterId_characterIdoffset_offsetlimit_limit(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__characterId_characterIdoffset_offsetlimit_limit: return ".execute(characterId:offset:limit:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willReturn: ComicsPage...) -> MethodStub {
            return Given(method: .m_execute__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_execute__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func execute(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, willProduce: (StubberThrows<ComicsPage>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_execute__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (ComicsPage).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>) -> Verify { return Verify(method: .m_execute__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(characterId: Parameter<Int>, offset: Parameter<Int>, limit: Parameter<Int>, perform: @escaping (Int, Int, Int) -> Void) -> Perform {
            return Perform(method: .m_execute__characterId_characterIdoffset_offsetlimit_limit(`characterId`, `offset`, `limit`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - GetCharactersUseCase

open class GetCharactersUseCaseMock: GetCharactersUseCase, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(offset: Int, limit: Int, searchText: String) throws -> CharactersPage {
        addInvocation(.m_execute__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`)))
		let perform = methodPerformValue(.m_execute__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))) as? (Int, Int, String) -> Void
		perform?(`offset`, `limit`, `searchText`)
		var __value: CharactersPage
		do {
		    __value = try methodReturnValue(.m_execute__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>.value(`offset`), Parameter<Int>.value(`limit`), Parameter<String>.value(`searchText`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for execute(offset: Int, limit: Int, searchText: String). Use given")
			Failure("Stub return value not specified for execute(offset: Int, limit: Int, searchText: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__offset_offsetlimit_limitsearchText_searchText(Parameter<Int>, Parameter<Int>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_execute__offset_offsetlimit_limitsearchText_searchText(let lhsOffset, let lhsLimit, let lhsSearchtext), .m_execute__offset_offsetlimit_limitsearchText_searchText(let rhsOffset, let rhsLimit, let rhsSearchtext)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOffset, rhs: rhsOffset, with: matcher), lhsOffset, rhsOffset, "offset"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher), lhsLimit, rhsLimit, "limit"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSearchtext, rhs: rhsSearchtext, with: matcher), lhsSearchtext, rhsSearchtext, "searchText"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__offset_offsetlimit_limitsearchText_searchText(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_execute__offset_offsetlimit_limitsearchText_searchText: return ".execute(offset:limit:searchText:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willReturn: CharactersPage...) -> MethodStub {
            return Given(method: .m_execute__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_execute__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func execute(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, willProduce: (StubberThrows<CharactersPage>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_execute__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (CharactersPage).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>) -> Verify { return Verify(method: .m_execute__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(offset: Parameter<Int>, limit: Parameter<Int>, searchText: Parameter<String>, perform: @escaping (Int, Int, String) -> Void) -> Perform {
            return Perform(method: .m_execute__offset_offsetlimit_limitsearchText_searchText(`offset`, `limit`, `searchText`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

