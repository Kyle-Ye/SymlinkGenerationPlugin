import Foundation
import PackagePlugin

@main
struct SymlinkGenerationPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let genPath = context.package.directory.appending(["..", "SymlinkGenerationPlugin", "bin", "SymlinkGeneration"])
        let inputDirectoryPath = target.directory
        let outputDirectoryPath = target.directory.appending("include")
        return [
            .prebuildCommand(
                displayName: "Cleaning include directory",
                executable: try context.tool(named: "rm").path,
                arguments: ["-rf", outputDirectoryPath.string],
                outputFilesDirectory: context.pluginWorkDirectory
            ),
            .prebuildCommand(
                displayName: "Making include directory",
                executable: try context.tool(named: "mkdir").path,
                arguments: [outputDirectoryPath.string],
                outputFilesDirectory: context.pluginWorkDirectory
            ),
            .prebuildCommand(
                displayName: "Generating Symlinks",
                executable: genPath,
                arguments: [inputDirectoryPath.string, outputDirectoryPath.string],
                outputFilesDirectory: context.pluginWorkDirectory
            ),
        ]
    }
}
