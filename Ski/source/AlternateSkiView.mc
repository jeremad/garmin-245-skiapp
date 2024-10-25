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

    function getField1() as String {
        return getStatus();
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

    function compute() as Void {
        computeStatus();
        var infos = Activity.getActivityInfo();
        if (infos.elapsedDistance != null) {
            _distance = infos.elapsedDistance / 1000;
        }
        if (infos.totalAscent != null) {
            _distance = infos.totalAscent.toNumber();
        }
        if (infos.totalDescent != null) {
            _distance = infos.totalDescent.toNumber();
        }
        WatchUi.requestUpdate();
    }
}
