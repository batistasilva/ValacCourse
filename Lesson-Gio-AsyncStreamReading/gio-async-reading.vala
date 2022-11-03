// valac --pkg gio-2.0 gio-async-reading.vala

MainLoop main_loop;

async void read_something_async (File file) {
    var text = new StringBuilder ();
    print ("Start...\n");
                
    try {
        var dis = new DataInputStream (file.read ());
        string line = null;
        while ((line = yield dis.read_line_async (Priority.DEFAULT)) != null) {
            text.append (line);
            text.append_c ('\n');
        }
        print (text.str);
    } catch (Error e) {
        error (e.message);
    }
    main_loop.quit ();
}

void main (string[] args) {
                
    var file = File.new_for_uri ("http://www.gnome.org");

    if (args.length > 1) {
        file = File.new_for_commandline_arg (args[1]);
    }

    main_loop = new MainLoop ();
    read_something_async (file);
    main_loop.run ();
}
