// Generated using Sourcery 1.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.4

import SwiftyMocky
import XCTest
import Foundation
@testable import MarvelApp


// MARK: - APIRestProviderProtocol

open class APIRestProviderProtocolMock: APIRestProviderProtocol, Mock {
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





    open func request<T: Endpoint>(endpoint: T, completion: @escaping (Result<T.Response, MarvelError>) -> Void) {
        addInvocation(.m_request__endpoint_endpointcompletion_completion(Parameter<T>.value(`endpoint`).wrapAsGeneric(), Parameter<(Result<T.Response, MarvelError>) -> Void>.value(`completion`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_request__endpoint_endpointcompletion_completion(Parameter<T>.value(`endpoint`).wrapAsGeneric(), Parameter<(Result<T.Response, MarvelError>) -> Void>.value(`completion`).wrapAsGeneric())) as? (T, @escaping (Result<T.Response, MarvelError>) -> Void) -> Void
		perform?(`endpoint`, `completion`)
    }


    fileprivate enum MethodType {
        case m_request__endpoint_endpointcompletion_completion(Parameter<GenericAttribute>, Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_request__endpoint_endpointcompletion_completion(let lhsEndpoint, let lhsCompletion), .m_request__endpoint_endpointcompletion_completion(let rhsEndpoint, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsEndpoint, rhs: rhsEndpoint, with: matcher), lhsEndpoint, rhsEndpoint, "endpoint"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_request__endpoint_endpointcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_request__endpoint_endpointcompletion_completion: return ".request(endpoint:completion:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func request<T>(endpoint: Parameter<T>, completion: Parameter<(Result<T.Response, MarvelError>) -> Void>) -> Verify where T:Endpoint { return Verify(method: .m_request__endpoint_endpointcompletion_completion(`endpoint`.wrapAsGeneric(), `completion`.wrapAsGeneric()))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func request<T>(endpoint: Parameter<T>, completion: Parameter<(Result<T.Response, MarvelError>) -> Void>, perform: @escaping (T, @escaping (Result<T.Response, MarvelError>) -> Void) -> Void) -> Perform where T:Endpoint {
            return Perform(method: .m_request__endpoint_endpointcompletion_completion(`endpoint`.wrapAsGeneric(), `completion`.wrapAsGeneric()), performs: perform)
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

// MARK: - CharactersServiceProtocol

open class CharactersServiceProtocolMock: CharactersServiceProtocol, Mock {
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





    open func getCharacters(_ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void) {
        addInvocation(.m_getCharacters__completionHandler(Parameter<(Result<CharactersResponse, MarvelError>) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_getCharacters__completionHandler(Parameter<(Result<CharactersResponse, MarvelError>) -> Void>.value(`completionHandler`))) as? (@escaping (Result<CharactersResponse, MarvelError>) -> Void) -> Void
		perform?(`completionHandler`)
    }

    open func getCharacterById(id: String, _ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void) {
        addInvocation(.m_getCharacterById__id_id_completionHandler(Parameter<String>.value(`id`), Parameter<(Result<CharactersResponse, MarvelError>) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_getCharacterById__id_id_completionHandler(Parameter<String>.value(`id`), Parameter<(Result<CharactersResponse, MarvelError>) -> Void>.value(`completionHandler`))) as? (String, @escaping (Result<CharactersResponse, MarvelError>) -> Void) -> Void
		perform?(`id`, `completionHandler`)
    }


    fileprivate enum MethodType {
        case m_getCharacters__completionHandler(Parameter<(Result<CharactersResponse, MarvelError>) -> Void>)
        case m_getCharacterById__id_id_completionHandler(Parameter<String>, Parameter<(Result<CharactersResponse, MarvelError>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getCharacters__completionHandler(let lhsCompletionhandler), .m_getCharacters__completionHandler(let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "_ completionHandler"))
				return Matcher.ComparisonResult(results)

            case (.m_getCharacterById__id_id_completionHandler(let lhsId, let lhsCompletionhandler), .m_getCharacterById__id_id_completionHandler(let rhsId, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "id"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "_ completionHandler"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getCharacters__completionHandler(p0): return p0.intValue
            case let .m_getCharacterById__id_id_completionHandler(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getCharacters__completionHandler: return ".getCharacters(_:)"
            case .m_getCharacterById__id_id_completionHandler: return ".getCharacterById(id:_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getCharacters(_ completionHandler: Parameter<(Result<CharactersResponse, MarvelError>) -> Void>) -> Verify { return Verify(method: .m_getCharacters__completionHandler(`completionHandler`))}
        public static func getCharacterById(id: Parameter<String>, _ completionHandler: Parameter<(Result<CharactersResponse, MarvelError>) -> Void>) -> Verify { return Verify(method: .m_getCharacterById__id_id_completionHandler(`id`, `completionHandler`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getCharacters(_ completionHandler: Parameter<(Result<CharactersResponse, MarvelError>) -> Void>, perform: @escaping (@escaping (Result<CharactersResponse, MarvelError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_getCharacters__completionHandler(`completionHandler`), performs: perform)
        }
        public static func getCharacterById(id: Parameter<String>, _ completionHandler: Parameter<(Result<CharactersResponse, MarvelError>) -> Void>, perform: @escaping (String, @escaping (Result<CharactersResponse, MarvelError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_getCharacterById__id_id_completionHandler(`id`, `completionHandler`), performs: perform)
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

// MARK: - Endpoint

open class EndpointMock<Response>: Endpoint, Mock where Response: Codable {
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

    public var baseURL: String {
		get {	invocations.append(.p_baseURL_get); return __p_baseURL ?? givenGetterValue(.p_baseURL_get, "EndpointMock - stub value for baseURL was not defined") }
	}
	private var __p_baseURL: (String)?

    public var path: String {
		get {	invocations.append(.p_path_get); return __p_path ?? givenGetterValue(.p_path_get, "EndpointMock - stub value for path was not defined") }
	}
	private var __p_path: (String)?

    public var method: RequestMethod {
		get {	invocations.append(.p_method_get); return __p_method ?? givenGetterValue(.p_method_get, "EndpointMock - stub value for method was not defined") }
	}
	private var __p_method: (RequestMethod)?

    public var parameters: [String: Any] {
		get {	invocations.append(.p_parameters_get); return __p_parameters ?? givenGetterValue(.p_parameters_get, "EndpointMock - stub value for parameters was not defined") }
	}
	private var __p_parameters: ([String: Any])?

    public var documentId: String? {
		get {	invocations.append(.p_documentId_get); return __p_documentId ?? optionalGivenGetterValue(.p_documentId_get, "EndpointMock - stub value for documentId was not defined") }
	}
	private var __p_documentId: (String)?





    open func request(timestamp: TimeInterval = Date().timeIntervalSince1970) -> URLRequest {
        addInvocation(.m_request__timestamp_timestamp(Parameter<TimeInterval>.value(`timestamp`)))
		let perform = methodPerformValue(.m_request__timestamp_timestamp(Parameter<TimeInterval>.value(`timestamp`))) as? (TimeInterval) -> Void
		perform?(`timestamp`)
		var __value: URLRequest
		do {
		    __value = try methodReturnValue(.m_request__timestamp_timestamp(Parameter<TimeInterval>.value(`timestamp`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for request(timestamp: TimeInterval = Date().timeIntervalSince1970). Use given")
			Failure("Stub return value not specified for request(timestamp: TimeInterval = Date().timeIntervalSince1970). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_request__timestamp_timestamp(Parameter<TimeInterval>)
        case p_baseURL_get
        case p_path_get
        case p_method_get
        case p_parameters_get
        case p_documentId_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_request__timestamp_timestamp(let lhsTimestamp), .m_request__timestamp_timestamp(let rhsTimestamp)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTimestamp, rhs: rhsTimestamp, with: matcher), lhsTimestamp, rhsTimestamp, "timestamp"))
				return Matcher.ComparisonResult(results)
            case (.p_baseURL_get,.p_baseURL_get): return Matcher.ComparisonResult.match
            case (.p_path_get,.p_path_get): return Matcher.ComparisonResult.match
            case (.p_method_get,.p_method_get): return Matcher.ComparisonResult.match
            case (.p_parameters_get,.p_parameters_get): return Matcher.ComparisonResult.match
            case (.p_documentId_get,.p_documentId_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_request__timestamp_timestamp(p0): return p0.intValue
            case .p_baseURL_get: return 0
            case .p_path_get: return 0
            case .p_method_get: return 0
            case .p_parameters_get: return 0
            case .p_documentId_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_request__timestamp_timestamp: return ".request(timestamp:)"
            case .p_baseURL_get: return "[get] .baseURL"
            case .p_path_get: return "[get] .path"
            case .p_method_get: return "[get] .method"
            case .p_parameters_get: return "[get] .parameters"
            case .p_documentId_get: return "[get] .documentId"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func baseURL(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_baseURL_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func path(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_path_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func method(getter defaultValue: RequestMethod...) -> PropertyStub {
            return Given(method: .p_method_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func parameters(getter defaultValue: [String: Any]...) -> PropertyStub {
            return Given(method: .p_parameters_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func documentId(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_documentId_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func request(timestamp: Parameter<TimeInterval>, willReturn: URLRequest...) -> MethodStub {
            return Given(method: .m_request__timestamp_timestamp(`timestamp`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func request(timestamp: Parameter<TimeInterval>, willProduce: (Stubber<URLRequest>) -> Void) -> MethodStub {
            let willReturn: [URLRequest] = []
			let given: Given = { return Given(method: .m_request__timestamp_timestamp(`timestamp`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLRequest).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func request(timestamp: Parameter<TimeInterval>) -> Verify { return Verify(method: .m_request__timestamp_timestamp(`timestamp`))}
        public static var baseURL: Verify { return Verify(method: .p_baseURL_get) }
        public static var path: Verify { return Verify(method: .p_path_get) }
        public static var method: Verify { return Verify(method: .p_method_get) }
        public static var parameters: Verify { return Verify(method: .p_parameters_get) }
        public static var documentId: Verify { return Verify(method: .p_documentId_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func request(timestamp: Parameter<TimeInterval>, perform: @escaping (TimeInterval) -> Void) -> Perform {
            return Perform(method: .m_request__timestamp_timestamp(`timestamp`), performs: perform)
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

// MARK: - URLSessionProtocol

open class URLSessionProtocolMock: URLSessionProtocol, Mock {
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





    open func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        addInvocation(.m_dataTask__with_requestcompletionHandler_completionHandler(Parameter<URLRequest>.value(`request`), Parameter<(Data?, URLResponse?, Error?) -> Void>.value(`completionHandler`)))
		let perform = methodPerformValue(.m_dataTask__with_requestcompletionHandler_completionHandler(Parameter<URLRequest>.value(`request`), Parameter<(Data?, URLResponse?, Error?) -> Void>.value(`completionHandler`))) as? (URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> Void
		perform?(`request`, `completionHandler`)
		var __value: URLSessionDataTask
		do {
		    __value = try methodReturnValue(.m_dataTask__with_requestcompletionHandler_completionHandler(Parameter<URLRequest>.value(`request`), Parameter<(Data?, URLResponse?, Error?) -> Void>.value(`completionHandler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void). Use given")
			Failure("Stub return value not specified for dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void). Use given")
		}
		return __value
    }

    open func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        addInvocation(.m_dataTaskPublisher__for_request(Parameter<URLRequest>.value(`request`)))
		let perform = methodPerformValue(.m_dataTaskPublisher__for_request(Parameter<URLRequest>.value(`request`))) as? (URLRequest) -> Void
		perform?(`request`)
		var __value: URLSession.DataTaskPublisher
		do {
		    __value = try methodReturnValue(.m_dataTaskPublisher__for_request(Parameter<URLRequest>.value(`request`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for dataTaskPublisher(for request: URLRequest). Use given")
			Failure("Stub return value not specified for dataTaskPublisher(for request: URLRequest). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_dataTask__with_requestcompletionHandler_completionHandler(Parameter<URLRequest>, Parameter<(Data?, URLResponse?, Error?) -> Void>)
        case m_dataTaskPublisher__for_request(Parameter<URLRequest>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_dataTask__with_requestcompletionHandler_completionHandler(let lhsRequest, let lhsCompletionhandler), .m_dataTask__with_requestcompletionHandler_completionHandler(let rhsRequest, let rhsCompletionhandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "with request"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletionhandler, rhs: rhsCompletionhandler, with: matcher), lhsCompletionhandler, rhsCompletionhandler, "completionHandler"))
				return Matcher.ComparisonResult(results)

            case (.m_dataTaskPublisher__for_request(let lhsRequest), .m_dataTaskPublisher__for_request(let rhsRequest)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRequest, rhs: rhsRequest, with: matcher), lhsRequest, rhsRequest, "for request"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_dataTask__with_requestcompletionHandler_completionHandler(p0, p1): return p0.intValue + p1.intValue
            case let .m_dataTaskPublisher__for_request(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_dataTask__with_requestcompletionHandler_completionHandler: return ".dataTask(with:completionHandler:)"
            case .m_dataTaskPublisher__for_request: return ".dataTaskPublisher(for:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func dataTask(with request: Parameter<URLRequest>, completionHandler: Parameter<(Data?, URLResponse?, Error?) -> Void>, willReturn: URLSessionDataTask...) -> MethodStub {
            return Given(method: .m_dataTask__with_requestcompletionHandler_completionHandler(`request`, `completionHandler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func dataTaskPublisher(for request: Parameter<URLRequest>, willReturn: URLSession.DataTaskPublisher...) -> MethodStub {
            return Given(method: .m_dataTaskPublisher__for_request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func dataTask(with request: Parameter<URLRequest>, completionHandler: Parameter<(Data?, URLResponse?, Error?) -> Void>, willProduce: (Stubber<URLSessionDataTask>) -> Void) -> MethodStub {
            let willReturn: [URLSessionDataTask] = []
			let given: Given = { return Given(method: .m_dataTask__with_requestcompletionHandler_completionHandler(`request`, `completionHandler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLSessionDataTask).self)
			willProduce(stubber)
			return given
        }
        public static func dataTaskPublisher(for request: Parameter<URLRequest>, willProduce: (Stubber<URLSession.DataTaskPublisher>) -> Void) -> MethodStub {
            let willReturn: [URLSession.DataTaskPublisher] = []
			let given: Given = { return Given(method: .m_dataTaskPublisher__for_request(`request`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (URLSession.DataTaskPublisher).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func dataTask(with request: Parameter<URLRequest>, completionHandler: Parameter<(Data?, URLResponse?, Error?) -> Void>) -> Verify { return Verify(method: .m_dataTask__with_requestcompletionHandler_completionHandler(`request`, `completionHandler`))}
        public static func dataTaskPublisher(for request: Parameter<URLRequest>) -> Verify { return Verify(method: .m_dataTaskPublisher__for_request(`request`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func dataTask(with request: Parameter<URLRequest>, completionHandler: Parameter<(Data?, URLResponse?, Error?) -> Void>, perform: @escaping (URLRequest, @escaping (Data?, URLResponse?, Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .m_dataTask__with_requestcompletionHandler_completionHandler(`request`, `completionHandler`), performs: perform)
        }
        public static func dataTaskPublisher(for request: Parameter<URLRequest>, perform: @escaping (URLRequest) -> Void) -> Perform {
            return Perform(method: .m_dataTaskPublisher__for_request(`request`), performs: perform)
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

