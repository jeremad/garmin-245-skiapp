import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Activity;


class AlternateSkiView extends BaseView {

    private var _distance = 0f;
    private var _ascent = 0;
    private var _descent = 0;

    function initialize() {
        BaseView.initialize();
    }

    function getFormattedAscent() as String {
        return _ascent + " mD+";
	}

    function getFormattedDescent() as String {
        return _descent + " mD-";
    }

    function getFormattedDistance() as String {
        return _distance.format("%.1f") + " km";
    }

    function getField2() as String {
        return getFormattedDistance();
    }

    function getField3() as String {
        return getFormattedAscent();
    }

    function getField4() as String {
        return getFormattedDescent();
    }

    function compute(infos as Activity.Info) as Void {
        _distance = infos.elapsedDistance == null ? 0f : infos.elapsedDistance / 1000;
        _ascent = infos.totalAscent == null ? 0 : infos.totalAscent.toNumber();
        _descent = infos.totalDescent == null ? 0 : infos.totalDescent.toNumber();
    }
}
