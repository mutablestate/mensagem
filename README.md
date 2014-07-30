#mensagem

Elixir command line app that prints out various kinds of messages.

At the moment, it prints out random quotes, like the Unix fortune app,
and reminders.

###Install

Download mensagem, change to the mensagem directory and run the following command:

    mix escript.build

###Use

Once you have built the script, it is treated like any other executable.
On Linux, you can run it with `./mensagem`. On Windows, just type in `mensagem`.

At the moment, mensagem (with no arguments) prints out random quotes and reminders.
The `-q` option will just print out quotes and the `-r` option will just print
out the reminders (the reminders functionality does not work yet -- please be
patient for a few more days).

###Status

Pre-pre-alpha.

####Author

This program has been developed by David Whitlock.

####License

Mensagem is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your
option) any later version.
