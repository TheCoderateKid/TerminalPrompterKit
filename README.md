# TerminalPrompterKit

**TerminalPrompterKit** is a lightweight Swift package for creating interactive command-line prompts. Whether you're building a simple CLI utility or a more complex terminal experience, this toolkit makes it easy to present questions and receive user input with style.

## Features

- Prompt users with custom questions
- Handle multiple prompt types
- Lightweight and easy to integrate
- Designed for Swift command-line tools

## Installation

To add TerminalPrompterKit to your Swift package, add the following to your `Package.swift`:

```swift
.package(path: "../TerminalPrompterKit")
```

Or use a relative/local package path depending on your setup.

Then add `"TerminalPrompterKit"` as a dependency in your target:

```swift
.target(
    name: "YourApp",
    dependencies: ["TerminalPrompterKit"]
)
```

## Usage

Here's a quick example of how to use `TerminalPrompterKit` in your Swift CLI:

```swift
import TerminalPrompterKit

let prompter = TerminalPrompter()

let name = prompter.ask("What's your name?")
print("Hello, \(name)!")
```

## Credits

Created by the Doughboys.

---

This toolkit was built to bring some of that Doughboys charm to the command line.
