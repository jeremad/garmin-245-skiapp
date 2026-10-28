import Toybox.Lang;
import Toybox.Test;
import Toybox.Time;
import Toybox.Time.Gregorian;


(:test)
function timeOfDayFormats24Hour(logger as Logger) as Boolean {
    Test.assertEqual("14:05", TimeOfDayView.formatTime(14, 5, true));
    Test.assertEqual("09:05", TimeOfDayView.formatTime(9, 5, true));
    Test.assertEqual("00:00", TimeOfDayView.formatTime(0, 0, true));
    return true;
}

(:test)
function timeOfDayFormats12Hour(logger as Logger) as Boolean {
    Test.assertEqual("2:05", TimeOfDayView.formatTime(14, 5, false));
    Test.assertEqual("9:05", TimeOfDayView.formatTime(9, 5, false));
    Test.assertEqual("12:00", TimeOfDayView.formatTime(0, 0, false));
    Test.assertEqual("12:30", TimeOfDayView.formatTime(12, 30, false));
    return true;
}

(:test)
function timeOfDayFormatsMeridiem(logger as Logger) as Boolean {
    Test.assertEqual("AM", TimeOfDayView.formatMeridiem(0, false));
    Test.assertEqual("AM", TimeOfDayView.formatMeridiem(11, false));
    Test.assertEqual("PM", TimeOfDayView.formatMeridiem(12, false));
    Test.assertEqual("PM", TimeOfDayView.formatMeridiem(23, false));
    Test.assertEqual("", TimeOfDayView.formatMeridiem(14, true));
    return true;
}

(:test)
function timeOfDayFormatsDate(logger as Logger) as Boolean {
    var moment = Gregorian.moment({:year=>2026, :month=>10, :day=>28, :hour=>14, :minute=>5});
    var info = Gregorian.utcInfo(moment, Time.FORMAT_MEDIUM);
    Test.assertEqual("Wed 28 Oct", TimeOfDayView.formatDate(info));
    return true;
}
