public class Scenario: BaseConstruct, Activatable, AutoEntityCreatable, Stateful {
    public var autoCreatedEntities: [Entity] = []
    public var states: [AnyKey: State] = [:]
    public var currentState: State?
}
