public class Application : Gtk.Application {

	public Application () {
		Object (
			application_id: "com.github.batistasilva.app10",
			flags: ApplicationFlags.FLAGS_NONE
		);
	}

	protected override void activate () {
		var window = new App10.Window (this);

		add_window (window);
	}
}
