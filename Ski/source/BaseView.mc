import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.ActivityRecording;
import Toybox.Timer;


class BaseView extends WatchUi.View {

    private var _timer = null as Timer.Timer?;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
    }

    function onShow() as Void {
        if (_timer == null) {
            _timer = new Timer.Timer();
        }
        _timer.start(method(:refresh), 1000, true);
        refresh();
    }

    function refresh() as Void {
        var infos = Activity.getActivityInfo();
        if (infos != null) {
            compute(infos);
        }
        WatchUi.requestUpdate();
    }

    function getStatus() as String {
        var session = getApp().getSession();
        if (session == null) {
            return "ready";
        } else if (session.isRecording()) {
            return "recording";
        }
        return "stopped";
    }

    function compute(infos as Activity.Info) as Void {}

    function getField1() as String {
        return getStatus();
    }

    function getField2() as String {
        return "";
    }

    function getField3() as String {
        return "";
    }

    function getField4() as String {
        return "";
    }

    function onUpdate(dc as Dc) as Void {
        var height = dc.getHeight();
        var width = dc.getWidth();
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_BLACK);
        dc.clear();
        dc.drawLine(0, height / 4, width, height / 4);
        dc.drawLine(0, height / 2, width, height / 2);
        dc.drawLine(0, 3 * height / 4, width, 3 * height / 4);
        var x = width / 2;
        var justify = Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER;
        // Fields are centered in their band; the top band is the narrowest part of the round screen, hence the smaller font
        dc.drawText(x, height / 8, Graphics.FONT_SMALL, getField1(), justify);
        dc.drawText(x, 3 * height / 8, Graphics.FONT_MEDIUM, getField2(), justify);
        dc.drawText(x, 5 * height / 8, Graphics.FONT_MEDIUM, getField3(), justify);
        dc.drawText(x, 7 * height / 8, Graphics.FONT_MEDIUM, getField4(), justify);
    }

    function onHide() as Void {
        if (_timer != null) {
            _timer.stop();
        }
    }
}
