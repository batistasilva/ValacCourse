public class Test : Gtk.Application {

	public Test () {
		Object (
			application_id: "com.app.lesson.app3",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var window = new Gtk.ApplicationWindow (this);
	 	window.title = "This is my Vala (App3)";
	 	window.window_position = Gtk.WindowPosition.CENTER;
	 	window.set_default_size (350, 80);
	 	window.show_all ();
	}

	public static int main (string[] args) {
		var test = new Test ();
		return test.run (args);
	}
}
