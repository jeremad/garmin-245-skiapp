import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;
import Toybox.Timer;


class BaseView extends WatchUi.View {

    private var _timer = null as Timer?;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
    }

    function onShow() as Void {
        if (_timer == null) {
            _timer = new Timer.Timer();
        }
        _timer.start(method(:compute), 1000, true);
    }

    function compute() as Void {}

    function getField1() as String {
        return "";
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
        dc.drawText(x, 10, Graphics.FONT_MEDIUM, getField1(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, 10 + height / 4, Graphics.FONT_MEDIUM, getField2() , Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, 10 + height / 2, Graphics.FONT_MEDIUM, getField3(), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, 10 + 3 * height / 4, Graphics.FONT_MEDIUM, getField4(), Graphics.TEXT_JUSTIFY_CENTER);
    }

    function onHide() as Void {
        if (_timer != null) {
            _timer.stop();
        }
    }
}
