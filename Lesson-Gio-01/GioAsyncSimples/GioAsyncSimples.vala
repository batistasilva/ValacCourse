// Demo class with async function
// Build with: valac --pkg=gio-2.0 example.vala

class Test.Async : GLib.Object {
    public async string say(string sentence) {
        GLib.Idle.add(this.say.callback);
        yield;
        return sentence;
    }
    public static int main(string[] args) {
        Test.Async myasync = new Test.Async();
        GLib.MainLoop mainloop = new GLib.MainLoop();
        myasync.say.begin("helloworld",
                          (obj, res) => {
                              string sentence = myasync.say.end(res);
                              print("%s\n", sentence);
                              mainloop.quit();
                          });
        mainloop.run();
        return 0;
    }
}
