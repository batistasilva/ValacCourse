project('com.app.lesson.cairo.app2','vala','c')

executable(
    meson.project_name(),
    'cairo-shaped.vala',
    dependencies:[
        dependency('gtk+-3.0'),
        dependency('gdk-3.0'),
        dependency('glib-2.0'),
        dependency('cairo'),
    ],
    link_args : ['-X', '-lm',],
    install: true
)
