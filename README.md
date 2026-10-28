# garmin-245-skiapp
Garmin 245 ski application

## Launcher icon

The icon is drawn once, in `Ski/resources/drawables/launcher_icon.svg`. Each watch expects its own launcher icon size, so `Ski/launcher-icons/` and the generated block at the end of `Ski/monkey.jungle` give every product an exactly sized copy. After changing the products in `manifest.xml` or the SVG, regenerate them (this needs the SDK Manager's device files):

```bash
python3 scripts/update_launcher_icons.py
```

## Tests

Unit tests live in `Ski/test/` and run in the Connect IQ simulator. From VS Code (with the `Ski` folder open), run **Monkey C: Run Tests**.

From the command line, with the SDK's `bin` directory on your `PATH` and the simulator running (`connectiq`):

```bash
monkeyc -t -f Ski/monkey.jungle -d fr245m -o bin/SkiTest.prg -y /path/to/developer_key.der
monkeydo bin/SkiTest.prg fr245m -t
```

`monkeydo` exits with status 1 even when every test passes, so check the `PASSED` / `FAILED` line at the end of its output.
