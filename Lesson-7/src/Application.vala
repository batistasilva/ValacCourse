public class Application : Gtk.Application {

	public Application () {
		Object (
			application_id: "com.app.lessond.app7",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var window = new App7.Window (this);

		add_window (window);
	}
}
