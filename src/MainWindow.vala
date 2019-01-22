using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window {

    private ListManager list_manager = ListManager.get_instance ();
    private StackManager stack_manager = StackManager.get_instance ();

    private HeaderBar header_bar = HeaderBar.get_instance ();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    construct {
        set_titlebar (header_bar);

        stack_manager.load_views (this);

        list_manager.get_list ().get_repositories ("");

        stack_manager.get_stack ().visible_child_name = "welcome-view";

        add_shortcuts ();
    }

    private void add_shortcuts () {
        key_press_event.connect ((e) => {
            switch (e.keyval) {
                case Gdk.Key.a:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        new AddEntry ();
                    }
                    break;
                case Gdk.Key.i:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        header_bar.import_names ();
                    }
                    break;
                case Gdk.Key.w:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        stack_manager.show_winner_view ();
                    }
                    break;
                case Gdk.Key.h:
                    if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                        new Cheatsheet ();
                    }
                    break;
                case Gdk.Key.f:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    header_bar.search_entry.grab_focus ();
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    this.destroy ();
                  }
                  break;
            }

            return false;
        });
    }
}
}
