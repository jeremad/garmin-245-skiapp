import Toybox.Graphics;
import Toybox.Lang;
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

    function formatTime(time as Long) as String {
        var secs = (time % (1000 * 60)) / 1000;
        var minutes = (time % (1000 * 3600)) / (1000 * 60);
        var hours = time / (1000 * 3600);
		return Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), secs.format("%02d")]);
	}

    function formatSpeed(speed as Float) as String {
        return speed.format("%.1f");
    }

    function onUpdate(dc as Dc) as Void {
        var infos = Activity.getActivityInfo();
        var time = infos.timerTime.toLong();
        dc.clear();
        var height = dc.getHeight();
        var width = dc.getWidth();
        var x = width / 2;
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        var str = null;
        if (_session == null) {
            str = "ready";
        } else if (_session.isRecording()) {
            str = "recording";
        } else {
            str = "stopped";
        }
        var cHR = infos.currentHeartRate == null ? 0 : infos.currentHeartRate;
        var speed = infos.currentSpeed == null ? 0.0 : infos.currentSpeed * 1000 / 3600;
        dc.drawText(x, 10, Graphics.FONT_MEDIUM, "SKI: " + str, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, height / 4, width, height / 4);
        dc.drawText(x, 10 + height / 4, Graphics.FONT_MEDIUM, "HR: " + cHR , Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, height / 2, width, height / 2);
        dc.drawText(x, 10 + height / 2, Graphics.FONT_MEDIUM, "Speed: " + formatSpeed(speed) + " km/h", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawLine(0, 3 * height / 4, width, 3 * height / 4);
        dc.drawText(x, 10 + 3 * height / 4, Graphics.FONT_MEDIUM, formatTime(time), Graphics.TEXT_JUSTIFY_CENTER);
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

}
