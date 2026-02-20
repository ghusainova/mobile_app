echo "Executing watch_runner script"
dart pub get
dart run build_runner watch --delete-conflicting-outputs
echo "Done!"