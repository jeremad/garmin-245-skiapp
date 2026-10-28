import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.WatchUi;


class TimeOfDayView extends BaseView {

    function initialize() {
        BaseView.initialize();
    }

    static function formatTime(hour as Number, min as Number, is24Hour as Boolean) as String {
        if (is24Hour) {
            return hour.format("%02d") + ":" + min.format("%02d");
        }
        var hour12 = hour % 12 == 0 ? 12 : hour % 12;
        return hour12 + ":" + min.format("%02d");
    }

    static function formatMeridiem(hour as Number, is24Hour as Boolean) as String {
        if (is24Hour) {
            return "";
        }
        return hour < 12 ? "AM" : "PM";
    }

    static function formatDate(info as Gregorian.Info) as String {
        return Lang.format("$1$ $2$ $3$", [info.day_of_week, info.day, info.month]);
    }

    function drawFields(dc as Dc) as Void {
        var height = dc.getHeight();
        var x = dc.getWidth() / 2;
        var now = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var is24Hour = System.getDeviceSettings().is24Hour;
        var timeFont = Graphics.FONT_NUMBER_HOT;
        dc.drawText(x, height / 2, timeFont, formatTime(now.hour, now.min, is24Hour), JUSTIFY);
        // Number fonts only have digits, so AM/PM goes in a text font just under the time
        dc.drawText(x, height / 2 + dc.getFontHeight(timeFont) / 2, Graphics.FONT_XTINY, formatMeridiem(now.hour, is24Hour), Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, 13 * height / 16, Graphics.FONT_SMALL, formatDate(now), JUSTIFY);
    }
}
