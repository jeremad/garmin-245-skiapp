# garmin-245-skiapp
Garmin 245 ski application

## Tests

Unit tests live in `Ski/test/` and run in the Connect IQ simulator. From VS Code (with the `Ski` folder open), run **Monkey C: Run Tests**.

From the command line, with the SDK's `bin` directory on your `PATH` and the simulator running (`connectiq`):

```bash
monkeyc -t -f Ski/monkey.jungle -d fr245m -o bin/SkiTest.prg -y /path/to/developer_key.der
monkeydo bin/SkiTest.prg fr245m -t
```

`monkeydo` exits with status 1 even when every test passes, so check the `PASSED` / `FAILED` line at the end of its output.
