from libqtile import widget

from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='light', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=5)


def icon(fontsize=16, text="?"):
    return widget.TextBox(
        **base(),
        fontsize=fontsize,
        text=text,
        padding=3
    )


def workspaces(): 
    return [
        widget.GroupBox(
            **base(),
            font='UbuntuMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=2,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=False,
            highlight_method='line',
            urgent_alert_method='line',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),

    icon(text=' '), # Icon: nf-fa-download
    
    widget.CheckUpdates(
        background=colors["dark"],
        colour_have_updates=colors['light'],
        colour_no_updates=colors['light'],
        no_update_string='0',
        display_format='{updates}',
        update_interval=1800,
        custom_command='checkupdates',
    ),

    separator(),

    icon(text=' '),  # Icon: nf-fa-feed
    
    widget.Net(**base(), interface='wlp2s0'),

    separator(),

    widget.CurrentLayoutIcon(**base(), scale=0.65),

    widget.CurrentLayout(**base(), padding=5),

    separator(),

    icon(fontsize=17, text='󱛡 '), # Icon: nf-mdi-calendar_clock

    widget.Clock(**base(), format='%d/%m/%Y %H:%M '),

    separator(),

    widget.Systray(background=colors['dark'], padding=5),
]

secondary_widgets = [
    *workspaces(),

    separator(),

    separator(),

    widget.CurrentLayoutIcon(**base(), scale=0.65),

    widget.CurrentLayout(**base(), padding=5),

    separator(),

    widget.Clock(**base(), format='%d/%m/%Y - %H:%M '),

    separator(),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
