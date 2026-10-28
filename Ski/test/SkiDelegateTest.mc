import Toybox.Lang;
import Toybox.Test;


(:test)
function pageIndexMovesForwardAndWraps(logger as Logger) as Boolean {
    Test.assertEqual(1, SkiDelegate.pageIndex(0, 1, 3));
    Test.assertEqual(2, SkiDelegate.pageIndex(1, 1, 3));
    Test.assertEqual(0, SkiDelegate.pageIndex(2, 1, 3));
    return true;
}

(:test)
function pageIndexMovesBackwardAndWraps(logger as Logger) as Boolean {
    Test.assertEqual(1, SkiDelegate.pageIndex(2, -1, 3));
    Test.assertEqual(0, SkiDelegate.pageIndex(1, -1, 3));
    Test.assertEqual(2, SkiDelegate.pageIndex(0, -1, 3));
    return true;
}
