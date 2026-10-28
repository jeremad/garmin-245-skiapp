import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;


class ExitMenuDelegate extends WatchUi.Menu2InputDelegate {

    static function createMenu() as WatchUi.Menu2 {
        var menu = new WatchUi.Menu2({:title=>"Exit"});
        menu.addItem(new WatchUi.MenuItem("Save & exit", null, :save, null));
        menu.addItem(new WatchUi.MenuItem("Discard & exit", null, :discard, null));
        menu.addItem(new WatchUi.MenuItem("Cancel", null, :cancel, null));
        return menu;
    }

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var id = item.getId();
        if (id == :save) {
            getApp().saveSession();
            System.exit();
        } else if (id == :discard) {
            // Discarding can't be undone, so ask once more
            WatchUi.pushView(new WatchUi.Confirmation("Discard activity?"), new $.DiscardConfirmationDelegate(), WatchUi.SLIDE_IMMEDIATE);
        } else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }
}
