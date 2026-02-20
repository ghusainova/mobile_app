### [Mason Generating][https://docs.brickhub.dev]

- install mason
  - `dart pub global activate mason_cli` | run task "mason activate"
  - reload vscode
- install vscode extension "Mason"
- choose a folder where to locate a module
- right-click "Mason: Make new local brick" and Enter
- choose options that you need (is bloc stateless, provider lazySingleton or not and etc)
- run build_runner / watch_runner:
  - `dart run build_runner watch --delete-conflicting-outputs` | run task "build runner" | run task "watch runner"
