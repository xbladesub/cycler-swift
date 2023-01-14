import AppKit
import ArgumentParser

@main
struct Cycler: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Simple tool to hide/show macOS apps by name or bundleId",
        version: "1.0.0",
        subcommands: []
    )

    @Argument(help: "Name or bundleId of the app")
    var nameOrId: String

    mutating func run() throws {
        let app = NSWorkspace.shared.runningApplications.first(where: {
            $0.localizedName?.lowercased() == nameOrId.lowercased() || $0.bundleIdentifier == nameOrId
        })

        if let app = app {
            let isHidden = app.isHidden
            if isHidden {
                NSWorkspace.shared.launchApplication(nameOrId)
            } else {
                app.hide()
            }
        } else {
            print("Failed to launch app with name or bundleId: \(nameOrId)")
        }
    }
}
