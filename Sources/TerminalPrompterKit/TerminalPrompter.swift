import Foundation

public class TerminalPrompter {
    private let questions: [DynamicQuestion]

    public init?(jsonPath: String) {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            print("Error: Could not read JSON file at \(jsonPath)")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            self.questions = try decoder.decode([DynamicQuestion].self, from: data)
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }

    public func run() {
        for (index, question) in questions.enumerated() {
            print("\nQuestion \(index + 1):")
            print(question.question)

            switch question.type {
            case "text":
                handleTextQuestion(question)
            case "multiple-choice":
                handleMultipleChoiceQuestion(question)
            default:
                print("Unsupported question type: \(question.type)")
            }
        }
    }

    private func handleTextQuestion(_ question: DynamicQuestion) {
        print(question.effectiveInputPrompt, terminator: "")
        if let input = readInput() {
            let response = input.isEmpty ? "" : input
            let responseText = question.effectiveResponseMessage.replacingOccurrences(of: "{{response}}", with: response)
            print(responseText)
        } else {
            print("Input cancelled.")
        }
    }

    private func handleMultipleChoiceQuestion(_ question: DynamicQuestion) {
        guard let labels = question.labels, let options = question.options, labels.count == options.count else {
            print("Error: Invalid multiple-choice data for '\(question.question)'")
            return
        }

        for (label, option) in zip(labels, options) {
            print("\(label). \(option)")
        }

        while true {
            print(question.effectiveInputPrompt, terminator: "")
            if let input = readInput(), let index = labels.firstIndex(of: input) {
                let responseText = question.effectiveResponseMessage
                    .replacingOccurrences(of: "{{option}}", with: options[index])
                    .replacingOccurrences(of: "{{label}}", with: labels[index])
                print(responseText)
                break
            } else {
                print(question.effectiveInvalidMessage)
            }
        }
    }

    private func readInput() -> String? {
        readLine()?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
