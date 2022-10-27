public class App9.Window : Gtk.ApplicationWindow {
	public GLib.Settings settings;

	public Window (Application app) {
		Object (
			application: app
		);
	}

	construct {
	 	//title = "This is my Vala Test";
	 	window_position = Gtk.WindowPosition.CENTER;
	 	set_default_size (350, 80);

	 	settings = new GLib.Settings ("com.github.batistasilva.app9");

	 	move (settings.get_int ("window-x"), settings.get_int ("window-y"));
	 	resize (settings.get_int ("window-w"), settings.get_int ("window-h"));

	 	delete_event.connect (e => {
	 		return before_destroy ();
	 	});

	 	var headerbar = new App9.HeaderBar ();
	 	set_titlebar (headerbar);

	 	show_all ();
	}

	public bool before_destroy () {
		int width, height, x, y;

		get_size (out width, out height);
		get_position (out x, out y);
		settings.set_int ("window-x", x);      
		settings.set_int ("window-y", y);
		settings.set_int ("window-w", width);
		settings.set_int ("window-h", height);
        
        stdout.printf("\nValue for Pos-x:%d and Pos-y:%d\n", x, y);
		return false;
	}
}
