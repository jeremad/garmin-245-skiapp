import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class SkiView extends WatchUi.View {

    private var _session = null;
    private var _timer = null;
    // Screen 0 is status, HR, speed, time
    // Screen 1 is status, distance, ascent, descent
    private var _screen = 0;
    const last_screen = 1;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
    }

    function onShow() as Void {
    }

    function formatTime(time as Long) as String {
        var secs = (time % (1000 * 60)) / 1000;
        var minutes = (time % (1000 * 3600)) / (1000 * 60);
        var hours = time / (1000 * 3600);
		return Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), secs.format("%02d")]);
	}

    function getData() as Array<String> {
        var str = null;
        if (_session == null) {
            str = "ready";
        } else if (_session.isRecording()) {
            str = "recording";
        } else {
            str = "stopped";
        }
        var infos = Activity.getActivityInfo();
        switch (_screen) {
            case 0:
                var time = infos.timerTime.toLong();
                var cHR = infos.currentHeartRate == null ? 0 : infos.currentHeartRate;
                var speed = infos.currentSpeed == null ? 0.0 : infos.currentSpeed * 1000 / 3600;
                return [
                    "SKI: " + str,
                    "HR: " + cHR,
                    "Speed: " + speed.format("%.1f") + " km/h",
                    formatTime(time)
                ];
            case 1:
                var distance = infos.elapsedDistance == null ? 0.0 : infos.elapsedDistance / 1000;
                var ascent = infos.totalAscent == null ? 0: infos.totalAscent.toNumber();
                var descent = infos.totalDescent == null ? 0: infos.totalDescent.toNumber();
                return [
                    "SKI: " + str,
                    "Distance: " + distance.format("%.2f"),
                    "D+: " + ascent + " m",
                    "D-: " + descent + " m",
                ];
            default:
                throw new Exception();
        }
    }

    function onUpdate(dc as Dc) as Void {
        var height = dc.getHeight();
        var width = dc.getWidth();
        var x = width / 2;
        var data = getData();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawText(x, 10, Graphics.FONT_MEDIUM, data[0], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, height / 4, width, height / 4);
        dc.drawText(x, 10 + height / 4, Graphics.FONT_MEDIUM, data[1] , Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, height / 2, width, height / 2);
        dc.drawText(x, 10 + height / 2, Graphics.FONT_MEDIUM, data[2], Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, 3 * height / 4, width, 3 * height / 4);
        dc.drawText(x, 10 + 3 * height / 4, Graphics.FONT_MEDIUM, data[3], Graphics.TEXT_JUSTIFY_CENTER);
    }


    function onHide() as Void {
    }

    function onSelect() as Void {
        if (_session == null) {
            _session = ActivityRecording.createSession({
                :name=>"Ski",
                :sport=>Activity.SPORT_ALPINE_SKIING,
            });
            _timer = new Timer.Timer();
            _timer.start(method(:ping), 50, true);
            _session.start();
        } else if (_session.isRecording()) {
            _session.stop();
        } else {
            _session.start();
        }
    }

    function close() as Void {
        if (_session != null) {
            if (_session.isRecording()) {
                _session.stop();
            }
            _session.save();
        }
        System.exit();
    }

    function ping() as Void {
        WatchUi.requestUpdate();
    }

    function next() as Void {
       _screen++;
       if (_screen > last_screen) {
        _screen = 0;
       }
       ping();
    }

    function previous() as Void {
       _screen--;
       if (_screen < 0) {
        _screen = last_screen;
       }
       ping();
    }
}
