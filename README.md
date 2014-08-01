#mensagem

Elixir command line app that prints out various kinds of messages.

At the moment, it prints out random quotes, like the Unix fortune app,
and reminders.

In the future, I hope to make it easy for other users to extend it,
so that they can print out any kind of message.

###Install

Download mensagem, change to the mensagem directory and run the following command:

    mix escript.build

###Use

Once you have built the script, it is treated like any other executable.
On Linux and Mac OS, you can run it with `./mensagem`. On Windows,
you need to type `escript mensagem`.

At the moment, mensagem (with no arguments) prints out random quotes and reminders.
The `-q` option will just print out quotes and the `-r` option will just print
out the reminders.

To add reminders, use the -a option, as in the example below:

    mensagem -a 2014/10/12 "Greet the wife."

At the moment, the date needs to be formatted Year/Month/Day
and the year must be written with four digits.

###Status

Pre-alpha.

####Author

This program has been developed by David Whitlock.

####License

Mensagem is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your
option) any later version.
