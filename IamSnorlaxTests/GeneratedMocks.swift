// MARK: - Mocks generated from file: IamSnorlax/ui/modules/generationList/interactor/GenerationListInteractor.swift at 2020-11-23 09:35:25 +0000

//
//  GenerationListInteractor.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Cuckoo
@testable import IamSnorlax

import RxSwift


 class MockGenerationListInteractor: GenerationListInteractor, Cuckoo.ClassMock {
    
     typealias MocksType = GenerationListInteractor
    
     typealias Stubbing = __StubbingProxy_GenerationListInteractor
     typealias Verification = __VerificationProxy_GenerationListInteractor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GenerationListInteractor?

     func enableDefaultImplementation(_ stub: GenerationListInteractor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var disposeBag: DisposeBag {
        get {
            return cuckoo_manager.getter("disposeBag",
                superclassCall:
                    
                    super.disposeBag
                    ,
                defaultCall: __defaultImplStub!.disposeBag)
        }
        
        set {
            cuckoo_manager.setter("disposeBag",
                value: newValue,
                superclassCall:
                    
                    super.disposeBag = newValue
                    ,
                defaultCall: __defaultImplStub!.disposeBag = newValue)
        }
        
    }
    

    

    
    
    
     override func fetchGenerations() -> PublishSubject<[String]?> {
        
    return cuckoo_manager.call("fetchGenerations() -> PublishSubject<[String]?>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.fetchGenerations()
                ,
            defaultCall: __defaultImplStub!.fetchGenerations())
        
    }
    
    
    
     override func fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?> {
        
    return cuckoo_manager.call("fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?>",
            parameters: (ids),
            escapingParameters: (ids),
            superclassCall:
                
                super.fetchGenerationsWith(ids: ids)
                ,
            defaultCall: __defaultImplStub!.fetchGenerationsWith(ids: ids))
        
    }
    

	 struct __StubbingProxy_GenerationListInteractor: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var disposeBag: Cuckoo.ClassToBeStubbedProperty<MockGenerationListInteractor, DisposeBag> {
	        return .init(manager: cuckoo_manager, name: "disposeBag")
	    }
	    
	    
	    func fetchGenerations() -> Cuckoo.ClassStubFunction<(), PublishSubject<[String]?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListInteractor.self, method: "fetchGenerations() -> PublishSubject<[String]?>", parameterMatchers: matchers))
	    }
	    
	    func fetchGenerationsWith<M1: Cuckoo.Matchable>(ids: M1) -> Cuckoo.ClassStubFunction<([String]), PublishSubject<[Generation]?>> where M1.MatchedType == [String] {
	        let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: ids) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListInteractor.self, method: "fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GenerationListInteractor: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var disposeBag: Cuckoo.VerifyProperty<DisposeBag> {
	        return .init(manager: cuckoo_manager, name: "disposeBag", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func fetchGenerations() -> Cuckoo.__DoNotUse<(), PublishSubject<[String]?>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("fetchGenerations() -> PublishSubject<[String]?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func fetchGenerationsWith<M1: Cuckoo.Matchable>(ids: M1) -> Cuckoo.__DoNotUse<([String]), PublishSubject<[Generation]?>> where M1.MatchedType == [String] {
	        let matchers: [Cuckoo.ParameterMatcher<([String])>] = [wrap(matchable: ids) { $0 }]
	        return cuckoo_manager.verify("fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GenerationListInteractorStub: GenerationListInteractor {
    
    
     override var disposeBag: DisposeBag {
        get {
            return DefaultValueRegistry.defaultValue(for: (DisposeBag).self)
        }
        
        set { }
        
    }
    

    

    
     override func fetchGenerations() -> PublishSubject<[String]?>  {
        return DefaultValueRegistry.defaultValue(for: (PublishSubject<[String]?>).self)
    }
    
     override func fetchGenerationsWith(ids: [String]) -> PublishSubject<[Generation]?>  {
        return DefaultValueRegistry.defaultValue(for: (PublishSubject<[Generation]?>).self)
    }
    
}


// MARK: - Mocks generated from file: IamSnorlax/ui/modules/generationList/presenter/GenerationListPresenter.swift at 2020-11-23 09:35:25 +0000

//
//  GenerationListPresenter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Cuckoo
@testable import IamSnorlax

import RxSwift


 class MockGenerationListPresenter: GenerationListPresenter, Cuckoo.ClassMock {
    
     typealias MocksType = GenerationListPresenter
    
     typealias Stubbing = __StubbingProxy_GenerationListPresenter
     typealias Verification = __VerificationProxy_GenerationListPresenter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GenerationListPresenter?

     func enableDefaultImplementation(_ stub: GenerationListPresenter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var view: PresenterToViewGenerationListProtocol? {
        get {
            return cuckoo_manager.getter("view",
                superclassCall:
                    
                    super.view
                    ,
                defaultCall: __defaultImplStub!.view)
        }
        
        set {
            cuckoo_manager.setter("view",
                value: newValue,
                superclassCall:
                    
                    super.view = newValue
                    ,
                defaultCall: __defaultImplStub!.view = newValue)
        }
        
    }
    
    
    
     override var interactor: PresenterToInteractorGenerationListProtocol? {
        get {
            return cuckoo_manager.getter("interactor",
                superclassCall:
                    
                    super.interactor
                    ,
                defaultCall: __defaultImplStub!.interactor)
        }
        
        set {
            cuckoo_manager.setter("interactor",
                value: newValue,
                superclassCall:
                    
                    super.interactor = newValue
                    ,
                defaultCall: __defaultImplStub!.interactor = newValue)
        }
        
    }
    
    
    
     override var router: PresenterToRouterGenerationListProtocol? {
        get {
            return cuckoo_manager.getter("router",
                superclassCall:
                    
                    super.router
                    ,
                defaultCall: __defaultImplStub!.router)
        }
        
        set {
            cuckoo_manager.setter("router",
                value: newValue,
                superclassCall:
                    
                    super.router = newValue
                    ,
                defaultCall: __defaultImplStub!.router = newValue)
        }
        
    }
    
    
    
     override var generations: PublishSubject<[Generation]?> {
        get {
            return cuckoo_manager.getter("generations",
                superclassCall:
                    
                    super.generations
                    ,
                defaultCall: __defaultImplStub!.generations)
        }
        
        set {
            cuckoo_manager.setter("generations",
                value: newValue,
                superclassCall:
                    
                    super.generations = newValue
                    ,
                defaultCall: __defaultImplStub!.generations = newValue)
        }
        
    }
    

    

    
    
    
     override func viewIsReady()  {
        
    return cuckoo_manager.call("viewIsReady()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.viewIsReady()
                ,
            defaultCall: __defaultImplStub!.viewIsReady())
        
    }
    
    
    
     override func navigateToVersionList(generation: Generation)  {
        
    return cuckoo_manager.call("navigateToVersionList(generation: Generation)",
            parameters: (generation),
            escapingParameters: (generation),
            superclassCall:
                
                super.navigateToVersionList(generation: generation)
                ,
            defaultCall: __defaultImplStub!.navigateToVersionList(generation: generation))
        
    }
    

	 struct __StubbingProxy_GenerationListPresenter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var view: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListPresenter, PresenterToViewGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "view")
	    }
	    
	    
	    var interactor: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListPresenter, PresenterToInteractorGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "interactor")
	    }
	    
	    
	    var router: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListPresenter, PresenterToRouterGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "router")
	    }
	    
	    
	    var generations: Cuckoo.ClassToBeStubbedProperty<MockGenerationListPresenter, PublishSubject<[Generation]?>> {
	        return .init(manager: cuckoo_manager, name: "generations")
	    }
	    
	    
	    func viewIsReady() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListPresenter.self, method: "viewIsReady()", parameterMatchers: matchers))
	    }
	    
	    func navigateToVersionList<M1: Cuckoo.Matchable>(generation: M1) -> Cuckoo.ClassStubNoReturnFunction<(Generation)> where M1.MatchedType == Generation {
	        let matchers: [Cuckoo.ParameterMatcher<(Generation)>] = [wrap(matchable: generation) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListPresenter.self, method: "navigateToVersionList(generation: Generation)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GenerationListPresenter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var view: Cuckoo.VerifyOptionalProperty<PresenterToViewGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "view", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var interactor: Cuckoo.VerifyOptionalProperty<PresenterToInteractorGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "interactor", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var router: Cuckoo.VerifyOptionalProperty<PresenterToRouterGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "router", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var generations: Cuckoo.VerifyProperty<PublishSubject<[Generation]?>> {
	        return .init(manager: cuckoo_manager, name: "generations", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func viewIsReady() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("viewIsReady()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func navigateToVersionList<M1: Cuckoo.Matchable>(generation: M1) -> Cuckoo.__DoNotUse<(Generation), Void> where M1.MatchedType == Generation {
	        let matchers: [Cuckoo.ParameterMatcher<(Generation)>] = [wrap(matchable: generation) { $0 }]
	        return cuckoo_manager.verify("navigateToVersionList(generation: Generation)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GenerationListPresenterStub: GenerationListPresenter {
    
    
     override var view: PresenterToViewGenerationListProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (PresenterToViewGenerationListProtocol?).self)
        }
        
        set { }
        
    }
    
    
     override var interactor: PresenterToInteractorGenerationListProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (PresenterToInteractorGenerationListProtocol?).self)
        }
        
        set { }
        
    }
    
    
     override var router: PresenterToRouterGenerationListProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (PresenterToRouterGenerationListProtocol?).self)
        }
        
        set { }
        
    }
    
    
     override var generations: PublishSubject<[Generation]?> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PublishSubject<[Generation]?>).self)
        }
        
        set { }
        
    }
    

    

    
     override func viewIsReady()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func navigateToVersionList(generation: Generation)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: IamSnorlax/ui/modules/generationList/router/GenerationListRouter.swift at 2020-11-23 09:35:25 +0000

//
//  GenerationListRouter.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Cuckoo
@testable import IamSnorlax

import UIKit


 class MockGenerationListRouter: GenerationListRouter, Cuckoo.ClassMock {
    
     typealias MocksType = GenerationListRouter
    
     typealias Stubbing = __StubbingProxy_GenerationListRouter
     typealias Verification = __VerificationProxy_GenerationListRouter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GenerationListRouter?

     func enableDefaultImplementation(_ stub: GenerationListRouter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func navigateToVersionList(viewController: UIViewController, generation: Generation)  {
        
    return cuckoo_manager.call("navigateToVersionList(viewController: UIViewController, generation: Generation)",
            parameters: (viewController, generation),
            escapingParameters: (viewController, generation),
            superclassCall:
                
                super.navigateToVersionList(viewController: viewController, generation: generation)
                ,
            defaultCall: __defaultImplStub!.navigateToVersionList(viewController: viewController, generation: generation))
        
    }
    

	 struct __StubbingProxy_GenerationListRouter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func navigateToVersionList<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(viewController: M1, generation: M2) -> Cuckoo.ClassStubNoReturnFunction<(UIViewController, Generation)> where M1.MatchedType == UIViewController, M2.MatchedType == Generation {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Generation)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: generation) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListRouter.self, method: "navigateToVersionList(viewController: UIViewController, generation: Generation)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GenerationListRouter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func navigateToVersionList<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(viewController: M1, generation: M2) -> Cuckoo.__DoNotUse<(UIViewController, Generation), Void> where M1.MatchedType == UIViewController, M2.MatchedType == Generation {
	        let matchers: [Cuckoo.ParameterMatcher<(UIViewController, Generation)>] = [wrap(matchable: viewController) { $0.0 }, wrap(matchable: generation) { $0.1 }]
	        return cuckoo_manager.verify("navigateToVersionList(viewController: UIViewController, generation: Generation)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GenerationListRouterStub: GenerationListRouter {
    

    

    
     override func navigateToVersionList(viewController: UIViewController, generation: Generation)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: IamSnorlax/ui/modules/generationList/view/GenerationListViewController.swift at 2020-11-23 09:35:25 +0000

//
//  GenerationListViewController.swift
//  IamSnorlax
//
//  Created by Diego Otero Mata on 22/10/2020.
//

import Cuckoo
@testable import IamSnorlax

import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit


 class MockGenerationListViewController: GenerationListViewController, Cuckoo.ClassMock {
    
     typealias MocksType = GenerationListViewController
    
     typealias Stubbing = __StubbingProxy_GenerationListViewController
     typealias Verification = __VerificationProxy_GenerationListViewController

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GenerationListViewController?

     func enableDefaultImplementation(_ stub: GenerationListViewController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var presenter: ViewToPresenterGenerationListProtocol? {
        get {
            return cuckoo_manager.getter("presenter",
                superclassCall:
                    
                    super.presenter
                    ,
                defaultCall: __defaultImplStub!.presenter)
        }
        
        set {
            cuckoo_manager.setter("presenter",
                value: newValue,
                superclassCall:
                    
                    super.presenter = newValue
                    ,
                defaultCall: __defaultImplStub!.presenter = newValue)
        }
        
    }
    
    
    
     override var generationTable: UITableView? {
        get {
            return cuckoo_manager.getter("generationTable",
                superclassCall:
                    
                    super.generationTable
                    ,
                defaultCall: __defaultImplStub!.generationTable)
        }
        
        set {
            cuckoo_manager.setter("generationTable",
                value: newValue,
                superclassCall:
                    
                    super.generationTable = newValue
                    ,
                defaultCall: __defaultImplStub!.generationTable = newValue)
        }
        
    }
    
    
    
     override var dataSource: [Generation]? {
        get {
            return cuckoo_manager.getter("dataSource",
                superclassCall:
                    
                    super.dataSource
                    ,
                defaultCall: __defaultImplStub!.dataSource)
        }
        
        set {
            cuckoo_manager.setter("dataSource",
                value: newValue,
                superclassCall:
                    
                    super.dataSource = newValue
                    ,
                defaultCall: __defaultImplStub!.dataSource = newValue)
        }
        
    }
    

    

    
    
    
     override func viewDidLoad()  {
        
    return cuckoo_manager.call("viewDidLoad()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.viewDidLoad()
                ,
            defaultCall: __defaultImplStub!.viewDidLoad())
        
    }
    
    
    
     override func setupView()  {
        
    return cuckoo_manager.call("setupView()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.setupView()
                ,
            defaultCall: __defaultImplStub!.setupView())
        
    }
    
    
    
     override func refresh()  {
        
    return cuckoo_manager.call("refresh()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.refresh()
                ,
            defaultCall: __defaultImplStub!.refresh())
        
    }
    

	 struct __StubbingProxy_GenerationListViewController: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var presenter: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListViewController, ViewToPresenterGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "presenter")
	    }
	    
	    
	    var generationTable: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListViewController, UITableView> {
	        return .init(manager: cuckoo_manager, name: "generationTable")
	    }
	    
	    
	    var dataSource: Cuckoo.ClassToBeStubbedOptionalProperty<MockGenerationListViewController, [Generation]> {
	        return .init(manager: cuckoo_manager, name: "dataSource")
	    }
	    
	    
	    func viewDidLoad() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListViewController.self, method: "viewDidLoad()", parameterMatchers: matchers))
	    }
	    
	    func setupView() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListViewController.self, method: "setupView()", parameterMatchers: matchers))
	    }
	    
	    func refresh() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGenerationListViewController.self, method: "refresh()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GenerationListViewController: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var presenter: Cuckoo.VerifyOptionalProperty<ViewToPresenterGenerationListProtocol> {
	        return .init(manager: cuckoo_manager, name: "presenter", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var generationTable: Cuckoo.VerifyOptionalProperty<UITableView> {
	        return .init(manager: cuckoo_manager, name: "generationTable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var dataSource: Cuckoo.VerifyOptionalProperty<[Generation]> {
	        return .init(manager: cuckoo_manager, name: "dataSource", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func viewDidLoad() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("viewDidLoad()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setupView() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("setupView()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func refresh() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("refresh()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GenerationListViewControllerStub: GenerationListViewController {
    
    
     override var presenter: ViewToPresenterGenerationListProtocol? {
        get {
            return DefaultValueRegistry.defaultValue(for: (ViewToPresenterGenerationListProtocol?).self)
        }
        
        set { }
        
    }
    
    
     override var generationTable: UITableView? {
        get {
            return DefaultValueRegistry.defaultValue(for: (UITableView?).self)
        }
        
        set { }
        
    }
    
    
     override var dataSource: [Generation]? {
        get {
            return DefaultValueRegistry.defaultValue(for: ([Generation]?).self)
        }
        
        set { }
        
    }
    

    

    
     override func viewDidLoad()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func setupView()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func refresh()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

