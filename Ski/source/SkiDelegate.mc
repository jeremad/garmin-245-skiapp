import Toybox.Lang;
import Toybox.WatchUi;


class SkiDelegate extends WatchUi.BehaviorDelegate {

    private var _ski_view as SkiView;
    private var _alternate_view as AlternateSkiView;
    private var _current_view = 0;
    private const _transition = WatchUi.SLIDE_IMMEDIATE;

    function initialize(ski_view as SkiView, alternate_view as AlternateSkiView) {
        BehaviorDelegate.initialize();
        _ski_view = ski_view;
        _alternate_view = alternate_view;
    }

    function onSelect() {
        getApp().toggleSession();
        WatchUi.requestUpdate();
        return true;
    }

    function switchPage() as Void {
        if (_current_view == 0) {
            WatchUi.switchToView(_alternate_view, self, _transition);
            _current_view = 1;
        } else {
            WatchUi.switchToView(_ski_view, self, _transition);
            _current_view = 0;
        }
    }

    function onNextPage() {
        switchPage();
        return true;
    }

    function onPreviousPage() {
        switchPage();
        return true;
    }

    function onBack() {
        if (getApp().getSession() == null) {
            // Nothing to save: let the default behavior pop the only view and exit
            return false;
        }
        WatchUi.pushView(new WatchUi.Confirmation("Save and exit?"), new $.ExitConfirmationDelegate(), _transition);
        return true;
    }
}
