import Toybox.Lang;
import Toybox.WatchUi;

class SkiDelegate extends WatchUi.BehaviorDelegate {

    private var _view as SkiView;

    function initialize(view as SkiView) {
        BehaviorDelegate.initialize();
        _view = view;
    }

    function onSelect() {
        if (Toybox has :ActivityRecording) {
            _view.onSelect();
        }
        return true;
    }

    function onBack() {
        _view.close();
        return true;
    }
}