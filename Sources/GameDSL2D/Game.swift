
public class Game: BaseConstruct {
    var scenes: [Scene] = []
    var gameStates: [GameState] = []

    override func didInitialize() {
        scenes = children(ofType: Scene.self)
        gameStates = children(ofType: GameState.self)
    }
}
