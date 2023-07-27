# GameDSL2D

**GameDSL2D** is a revolutionary Swift Package designed to empower game developers who utilize Apple's GameplayKit and SpriteKit to create their dream games and interactive experiences. It offers an intuitive and expressive domain-specific language (DSL) inspired by SwiftUI, facilitating the creation of complex games with less boilerplate and more creativity.

Game development is often constrained by the verbosity and complexity of game engines, which can hinder the creative process. With GameDSL2D, the barriers are lowered, and your ideas can quickly transform into code. The package makes game development feel more like a fluid process of composition and less like engineering.

```swift
import GameDSL2D

Game {
    Level(named: "Space Adventure") {
        Scenario(named: "Alien Invasion") {
            Entity(named: "Player") {
                ControlComponent()
                PhysicsComponent(physicsBody: playerBody)
                PositionComponent(x: 0, y: 0)
                SpriteComponent(named: "spaceship")
            }

            Entity(named: "Alien") {
                AIComponent()
                PhysicsComponent(physicsBody: alienBody)
                PositionComponent(x: 0, y: 500)
                SpriteComponent(named: "alien")
            }
            .population(count: 55, layout: .grid)
        }
    }

    InputComponent()
    SoundComponent()
}.run()
```

The GameDSL2D focuses on the essential aspects of game development:

- **Entity-Component-System (ECS) Architecture**: The library's core is built around the ECS pattern, a common architectural paradigm in game development. It helps keep your code organized, modular, and easy to iterate on. GameDSL2D automates much of the boilerplate that comes with implementing ECS, so you can focus more on building gameplay features.

- **Simple, Declarative Syntax**: Inspired by SwiftUI, GameDSL2D provides a clean and expressive syntax that's easy to read and write. This approach reduces the cognitive load of understanding the game logic, enabling you to be in a creative "flow state".

- **Event-Driven Programming**: In GameDSL2D, game events such as collisions, damage, or custom events you define, can be subscribed to and handled elegantly. This mechanism simplifies inter-component communication and contributes to clearer and more modular game logic.

- **Lazy Initialization and Resource Management**: With a focus on performance and efficiency, GameDSL2D implements lazy initialization and strategic resource management. Only the necessary objects are initialized and present in memory at any given time, ensuring your game runs smoothly across various Apple devices.

- **Built-in Animation System**: GameDSL2D comes with a simple, but powerful animation system. Whether it's making your character move, trees sway, or implementing custom animations, the built-in animation system makes it easy to bring your game world to life.

- **Flexibility and Extensibility**: While GameDSL2D provides a comprehensive set of components and systems, it doesn't limit you to just those. It's designed to be extensible so you can create and integrate your own custom components and systems into the DSL syntax.

Whether you are developing a simple 2D game or an immersive, interactive experience, GameDSL2D has got you covered. However, it is crucial to mention that as the complexity and scope of your game increases, the need for additional custom systems and components will arise. The GameDSL2D excels in simplifying and streamlining the game development process for SpriteKit and GameplayKit users, making it an excellent starting point for small to medium-sized projects and a good prototyping tool for larger ones.

## Installation

You can add GameDSL2D to your project using Swift Package Manager. In Xcode, click `File -> Swift Packages -> Add Package Dependency` and enter the URL of this repository.

## Usage

GameDSL2D is meant to provide a clean and intuitive interface for structuring your game's code. It helps you create and manage entities, components, systems, and more using a builder-style syntax.

```swift
let level = Level {
    Scenario("My Scenario") {
        Entity("My Entity") {
            MyComponent()
        }
    }
}
```

For more detailed usage instructions, check out our [Wiki](link_to_wiki).

## Contribution

We welcome contributions to GameDSL2D! If you'd like to contribute, please fork the repository, make your changes, and submit a pull request. If you have any questions, feel free to open an issue or reach out to us directly.

## License

GameDSL2D is available under the MIT license. See the LICENSE file for more info.
