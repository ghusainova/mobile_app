echo "Executing build_runner script"
dart pub get
dart run build_runner build --delete-conflicting-outputs
echo "Done!"