#!/usr/bin/env vala --pkg=alsa

void checkResultAndExitIfNecessary( string msg, int result )
{
    if ( result < 0 )
    {
        error( @"$msg FAIL: $(strerror(errno))" );
        Posix.exit( -1 );
    }
    else
    {
        message( @"$msg OK" );
    }
}

void dumpMidiEvent( Alsa.SeqEvent event )
{
    switch ( event.type )
    {
        case Alsa.SeqEventType.CONTROLLER:
            print( "Control event on Channel %2d: %5d\n",
                    event.control.channel, event.control.value);
            break;
        case Alsa.SeqEventType.PITCHBEND:
            print( "Pitchbender event on Channel %2d: %5d\n",
                    event.control.channel, event.control.value);
            break;
        case Alsa.SeqEventType.NOTEON:
            print( "Note On event on Channel %2d: %5d\n",
                    event.control.channel, event.note.note);
            break;
        case Alsa.SeqEventType.NOTEOFF:
            print( "Note Off event on Channel %2d: %5d\n",
                    event.control.channel, event.note.note);
            break;
        case Alsa.SeqEventType.PORT_SUBSCRIBED:
            print( "Port subscribed. %u:%u -> %u:%u\n",
            event.connect.sender.client, event.connect.sender.port,
            event.connect.dest.client, event.connect.dest.port );
            break;
        default:
            print( @"Ignoring unrecognized event: $(event.type)\n" );
            break;
    }
}

int main( string[] args )
{
    Alsa.SeqDevice device;
    var ok = Alsa.SeqDevice.open( out device, "hw", Alsa.SeqOpenMode.DUPLEX, 0 );
    checkResultAndExitIfNecessary( "Open sequencer", ok );
    device.set_client_name( "Vala MIDI Demo" );

    var portid = device.create_simple_port(
        "VALA MIDI Demo Port",
        Alsa.SeqPortCap.WRITE | Alsa.SeqPortCap.SUBS_WRITE,
        Alsa.SeqPortType.APPLICATION );
    checkResultAndExitIfNecessary( "Create port", portid );

    var npfd = device.poll_descriptors_count( Posix.POLLIN );
    var pfd = new Posix.pollfd[npfd];

    ok = device.poll_descriptors( pfd, Posix.POLLIN );
    checkResultAndExitIfNecessary( "Get poll descriptors", ok );

    while ( true )
    {
        Alsa.SeqEvent event;

        if ( Posix.poll( pfd, 100000 ) > 0 )
        {
            do
            {
                device.event_input( out event );
                dumpMidiEvent( event );
            }
            while ( device.event_input_pending( false ) > 0 );
        }
    }

    return 0;
}
