public class Jarvis.Window : Gtk.ApplicationWindow {

	public Window (Application app) {
		Object (
			application: app
		);
	}

	construct {
	 	title = "This is my Vala Test for (App6)";
	 	window_position = Gtk.WindowPosition.CENTER;
	 	set_default_size (350, 80);

	 	var settings = new GLib.Settings ("com.github.batistasilva.app6");

	 	move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));

	 	show_all ();
	}
}
