public class Application : Gtk.Application {

	public Application () {
		Object (
			application_id: "com.app.lesson.app9",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var window = new App9.Window (this);

		add_window (window);
	}
}
