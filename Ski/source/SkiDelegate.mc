import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
import Toybox.Position;


class SkiDelegate extends WatchUi.BehaviorDelegate {

    private var _ski_view as SkiView;
    private var _alternate_view as AlternateSkiView;
    private var _session = null as Session?;
    private var _current_view = 0;
    private const _transition = WatchUi.SLIDE_IMMEDIATE;

    function initialize(ski_view as SkiView, alternate_view as AlternateSkiView) {
        BehaviorDelegate.initialize();
        _ski_view = ski_view;
        _alternate_view = alternate_view;
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, null);
    }

    function onSelect() {
        if (_session == null) {
            _session = ActivityRecording.createSession({
                :name=>"Ski",
                :sport=>Activity.SPORT_ALPINE_SKIING,
            });
            _session.start();
        } else if (_session.isRecording()) {
            _session.stop();
        } else {
            _session.start();
        }
        _ski_view.setSession(_session);
        return true;
    }

    function switchPage() as Void {
        if (_current_view == 0) {
            WatchUi.pushView(_alternate_view, self, _transition);
            _current_view++;
        } else if (_current_view == 1) {
            WatchUi.popView(_transition);
            _current_view--;
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
        if (_session != null) {
            if (_session.isRecording()) {
                _session.stop();
            }
            _session.save();
            _ski_view.setSession(null);
            _session = null;
        }
        System.exit();
    }
}