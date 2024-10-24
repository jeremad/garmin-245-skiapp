import Toybox.Graphics;
import Toybox.WatchUi;

class SkiView extends WatchUi.View {

    private var _session = null;
    private var _timer = null;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
    }

    function onShow() as Void {
    }

    function onUpdate(dc as Dc) as Void {
        var infos = Activity.getActivityInfo();
        var time = infos.elapsedTime.toLong();
        dc.clear();
        var x = dc.getWidth() / 2;
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var hours = time / (1000 * 3600);
        var minutes = (time % (1000 * 3600)) / (1000 * 60);
        var secs = (time % (1000 * 60)) / 1000;
        var cents = (time % 1000) / 10;
        var str = null;
        if (_session == null) {
            str = "ready";
        } else if (_session.isRecording()) {
            str = "recording";
        } else {
            str = "stopped";
        }
        dc.drawText(x, 20, Graphics.FONT_TINY, "SKI: " + str, Graphics.TEXT_JUSTIFY_CENTER);
        if (infos.currentHeartRate != null) {
            dc.drawText(x, 70, Graphics.FONT_MEDIUM, "HR: " + infos.currentHeartRate , Graphics.TEXT_JUSTIFY_CENTER);
        }
        if (infos.currentSpeed != null && infos.currentSpeed != 0) {
            dc.drawText(x, 120, Graphics.FONT_MEDIUM, "Speed: " + (infos.currentSpeed * 1000 / 3600) + "km/h", Graphics.TEXT_JUSTIFY_CENTER);
        }
        dc.drawText(x, 170, Graphics.FONT_MEDIUM, "" + hours + ":" + minutes + ":" + secs + "." + cents, Graphics.TEXT_JUSTIFY_CENTER);
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
            _timer.start(method(:ping), 100, true);
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

}
