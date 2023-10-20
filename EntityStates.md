### Entity States

[See EntityStateKey.swift](./Sources/GameDSL2D/EntityStateKey.swift) for enums with many common entity states.

#### Available State Categories:

1. **EntityStateKey**: General-purpose states applicable to many types of entities.
2. **EnemyStateKey**: States related to NPC enemies.
3. **FlyingStateKey**: States specifically for flying entities.
4. **VehicleStateKey**: States for entities that are vehicles or are controlling vehicles.
5. **PlayerStateKey**: States specifically for player-controlled entities.
6. **ItemStateKey**: States for items or collectibles.
7. **SceneStateKey**: States for the game scene or level.
8. **EconomicStateKey**: States for economic transactions and statuses.
9. **PuzzleStateKey**: States for puzzle elements.
10. **StrategyStateKey**: States for strategy game elements.
11. **AnimationStateKey**: States for animation cycles.
12. **MultiplayerStateKey**: States for multiplayer settings.
13. **WeatherStateKey**: States for in-game weather conditions.
14. **NarrativeStateKey**: States for story-driven elements.
15. **MotionStateKey**: States for basic motion and actions.
16. **ConditionStateKey**: States for conditional or status effects.
17. **ProjectileStateKey**: States for projectiles.
18. **SpecialStateKey**: States for specialized or less common conditions.

#### Adding Custom State Categories:

Since Swift doesn't allow extending enums outside of the module where they are defined, you can't directly extend our provided state categories. However, you can create your own state categories using a protocol to match our existing design.

Here's how:

1. **Create Your Custom State Category Enum**: Ensure it conforms to `KeyProtocol`.

    ```swift
    import GameDSL2D

    public enum CustomStateKey: String, KeyProtocol {
        case yourState1
        case yourState2
        // more states...

        var stringValue: String {
            return self.rawValue
        }
    }
    ```

2. **Implement the `enter` Method**: Add a method in your game entity class to handle entering states for your custom category.

    ```swift
    extension Entity {
        public func enterCustomState(_ key: CustomStateKey) {
            self.enterState(AnyKey(key.stringValue))
        }
    }
    ```

By following these steps, you'll be able to add custom state categories that work alongside our built-in ones.
