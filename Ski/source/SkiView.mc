import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;


class SkiView extends BaseView {

    private var _heart_rate = 0;
    private var _speed = 0f;
    private var _time = 0;

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
        return _heart_rate + " bpm";
    }

    function getFormattedSpeed() as String {
        return _speed.format("%.1f") + " km/h";
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

    function compute(infos as Activity.Info) as Void {
        _heart_rate = infos.currentHeartRate == null ? 0 : infos.currentHeartRate;
        // currentSpeed is in m/s
        _speed = infos.currentSpeed == null ? 0f : infos.currentSpeed * 3.6;
        _time = infos.timerTime == null ? 0 : infos.timerTime;
    }
}
