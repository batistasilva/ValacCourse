// valac --pkg gio-2.0 gio-udp-demo.vala

int main () {
    try {

        var socket = new Socket (SocketFamily.IPV4,
                                 SocketType.DATAGRAM, 
                                 SocketProtocol.UDP);
        var sa = new InetSocketAddress (new InetAddress.loopback (SocketFamily.IPV4),
                                        3333);
        socket.bind (sa, true);

        var source = socket.create_source (IOCondition.IN);
        source.set_callback ((s, cond) => {
            try {
                uint8 buffer[4096];
                size_t read = s.receive (buffer);
                buffer[read] = 0; // null-terminate string
                print ("Got %ld bytes of data: %s", (long) read, (string) buffer);
            } catch (Error e) {
                stderr.printf (e.message);
            }
            return true;
        });
        source.attach (MainContext.default ());

        new MainLoop ().run ();
        
    } catch (Error e) {
        stderr.printf (e.message);
        return 1;
    }
    
    return 0;
}
