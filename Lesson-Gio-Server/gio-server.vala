// valac --pkg gio-2.0 gio-server.vala

void process_request (InputStream input, OutputStream output) throws Error {
    var data_in = new DataInputStream (input);
    string line;
    while ((line = data_in.read_line (null)) != null) {
        stdout.printf ("%s\n", line);
        if (line.strip () == "") break;
    }

    string content = "<html><h1>Hello from Vala server</h1></html>";
    var header = new StringBuilder ();
    header.append ("HTTP/1.0 200 OK\r\n");
    header.append ("Content-Type: text/html\r\n");
    header.append_printf ("Content-Length: %lu\r\n\r\n", content.length);

    output.write (header.str.data);
    output.write (content.data);
    output.flush ();
}

int main () {
    try {
        var service = new SocketService ();
        service.add_inet_port (8080, null);
        service.start ();
        while (true) {
            var conn = service.accept (null);
            process_request (conn.input_stream, conn.output_stream);
        }
    } catch (Error e) {
        stderr.printf ("%s\n", e.message);
    }
    return 0;
}
