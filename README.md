This repository allows users to quickly replicate the error that occurs when trying to link to object files that both include GLwMDrawA.h from Red Hat Enterprise Linux 7.

To test this module, ensure that Xt/GLw is installed on RHEL7.  Then run:

    make

This should produce the following output.


    g++ -c foo.c++
    g++ -c main.c++
    g++ foo.o main.o
    main.o:(.bss+0x0): multiple definition of `glwMDrawingAreaWidgetClass'
    foo.o:(.bss+0x0): first defined here
    collect2: error: ld returned 1 exit status
    make: *** [main] Error 1

I believe this has something to do with the [-fvisibility support in GCC 4](https://gcc.gnu.org/wiki/Visibility).  This was applied to GLw  when [extern keywords were replaced with GLAPI](https://cgit.freedesktop.org/mesa/mesa/commit/?id=4e5c51a05e70c215b284a38fc35850b485bbee8d) which is defined as follows when `__GCC__ >= 4`.

gl.h:

    #define GLAPI __attribute__((visibility("default")))

GLwDrawA.h:

    GLAPI WidgetClass glwMDrawingAreaWidgetClass;

One workaround (with questionable side effects) is to compile with `-D__GNUC__=3`.
