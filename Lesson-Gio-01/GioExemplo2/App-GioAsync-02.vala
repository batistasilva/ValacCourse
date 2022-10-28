// Async method to run a slow calculation in a background thread.
// Build with: valac --pkg=gio-2.0 example.vala

/*
 * With Vala 0.38+ this should compile without warnings, although you may want
 * to use the valac option `--target-glib 2.44` in your own code for maximum 
 * compatibility with GTask callbacks.
 * With Vala 0.36 use `--target-glib 2.44` or `--target-glib 2.36` to avoid the 
 * GSimpleAsyncResult deprecated warnings
 * With Vala before 0.32 use `--target-glib 2.32` to expose the bindings for the Thread constructors
 * Vala 0.16 is the minimum version required
 */

async double do_calc_in_bg(double val) throws ThreadError {
    SourceFunc callback = do_calc_in_bg.callback;
    double[] output = new double[1];

    // Hold reference to closure to keep it from being freed whilst
    // thread is active.
    ThreadFunc<bool> run = () => {
        // Perform a dummy slow calculation.
        // (Insert real-life time-consuming algorithm here.)
        double result = 0;
        for (int a = 0; a<100000000; a++)
            result += val * a;

        // Pass back result and schedule callback
        output[0] = result;
        Idle.add((owned) callback);
        return true;
    };
    new Thread<bool>("thread-example", run);

    // Wait for background thread to schedule our callback
    yield;
    return output[0];
}

void main(string[] args) {
    var loop = new MainLoop();
    do_calc_in_bg.begin(0.001, (obj, res) => {
            try {
                double result = do_calc_in_bg.end(res);
                stderr.printf(@"Result: $result\n");
            } catch (ThreadError e) {
                string msg = e.message;
                stderr.printf(@"Thread error: $msg\n");
            }
            loop.quit();
        });
    loop.run();
}
