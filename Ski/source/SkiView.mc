import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.ActivityRecording;


class SkiView extends BaseView {

    private var _heat_rate = 0;
    private var _speed = 0f;
    private var _time = 0;
    private var _status = "ready" as String;
    private var _session = null as Session?;

    function initialize() {
        BaseView.initialize();
    }

    function getFormattedTime() as String {
        var secs = (_time % (1000 * 60)) / 1000;
        var minutes = (_time % (1000 * 3600)) / (1000 * 60);
        var hours = _time / (1000 * 3600);
		return Lang.format("$1$:$2$:$3$", [hours.format("%02d"), minutes.format("%02d"), secs.format("%02d")]);
	}

    function getFormattedHR() as String {
        return _heat_rate + " bpm";
    }

    function getFormattedSpeed() as String {
        return _speed.format("%.1f") + " km/h";
    }

    function getStatus() as String {
        return _status;
    }

    function setSession(session as Session?) {
        _session = session;
    }

    function getField1() as String {
        return getStatus();
    }

    function getField2() as String {
        return getFormattedHR();
    }

    function getField3() as String {
        return getFormattedSpeed();
    }

    function getField4() as String {
        return getFormattedTime();
    }

    function compute() as Void {
        if (_session == null) {
            _status = "ready";
        } else if (_session.isRecording()) {
            _status = "recording";
        } else {
            _status = "stopped";
        }
        var infos = Activity.getActivityInfo();
        if (infos.currentHeartRate != null) {
            _heat_rate = infos.currentHeartRate;
        }
        if (infos.currentSpeed != null) {
            _speed = infos.currentSpeed * 3.6f;
        }
        _time = infos.timerTime.toLong();
        WatchUi.requestUpdate();
    }
}
