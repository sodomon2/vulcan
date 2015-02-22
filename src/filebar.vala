namespace Journal
{
	public class FileBar : Gtk.Box
	{
		public Application root;
		public Window mother;
		public Window window;
		
		public Gtk.Button new_button;
		public Gtk.Button open_button;
		public Gtk.Button save_button;
		public Gtk.Button saveas_button;
		public Gtk.Button sidebar_button;
		
		public FileBar(Window mother)
		{
			this.root = mother.root;
			this.mother = mother;
			this.window = this.mother.window;
			
			this.set_margin_start(4);
			this.set_margin_end(4);
			this.set_margin_top(4);
			this.set_margin_bottom(4);
			
			this.orientation = Gtk.Orientation.VERTICAL;
			
			this.new_button = new Gtk.Button();
			this.new_button.set_relief(Gtk.ReliefStyle.NONE);
			this.new_button.set_tooltip_text("Create a new file");
			this.new_button.set_image(new Gtk.Image.from_icon_name("document-new-symbolic", Gtk.IconSize.MENU));
			this.new_button.clicked.connect(this.newFileButtonClicked);
			this.add(this.new_button);
			
			this.open_button = new Gtk.Button();
			this.open_button.set_relief(Gtk.ReliefStyle.NONE);
			this.open_button.set_tooltip_text("Open an existing file");
			this.open_button.set_image(new Gtk.Image.from_icon_name("document-open-symbolic", Gtk.IconSize.MENU));
			this.open_button.clicked.connect(this.openFileButtonClicked);
			this.add(this.open_button);
			
			this.save_button = new Gtk.Button();
			this.save_button.set_relief(Gtk.ReliefStyle.NONE);
			this.save_button.set_tooltip_text("Save the current file");
			this.save_button.set_image(new Gtk.Image.from_icon_name("document-save-symbolic", Gtk.IconSize.MENU));
			this.add(this.save_button);
			
			this.saveas_button = new Gtk.Button();
			this.saveas_button.set_relief(Gtk.ReliefStyle.NONE);
			this.saveas_button.set_tooltip_text("Save the current file as a different file");
			this.saveas_button.set_image(new Gtk.Image.from_icon_name("document-save-as-symbolic", Gtk.IconSize.MENU));
			this.add(this.saveas_button);
			
			Gtk.Box spacer = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
			spacer.set_vexpand(true);
			this.add(spacer);
			
			this.sidebar_button = new Gtk.Button();
			this.sidebar_button.set_relief(Gtk.ReliefStyle.NONE);
			this.sidebar_button.set_tooltip_text("Toggle the sidebar visibility");
			this.sidebar_button.clicked.connect(this.sideBarButtonClicked);
			this.sidebar_button.set_image(new Gtk.Image.from_icon_name("pane-hide-symbolic", Gtk.IconSize.MENU));
			this.add(this.sidebar_button);
		}
		
		public void sideBarButtonClicked()
		{
			if (this.window.config.getProperty("show-sidebar") == "false")
				this.window.config.setProperty("show-sidebar", "true");
			else
				this.window.config.setProperty("show-sidebar", "false");
		}
		
		public void newFileButtonClicked()
		{
			this.window.newFile();
		}
		
		public void openFileButtonClicked()
		{
			this.window.openFileWithDialog();
		}
		
		public void update()
		{
			if (this.window.source_stack.getCurrentTab() != null)
			{
				if (this.window.source_stack.getCurrentTab().unsaved)
				{
					this.save_button.override_background_color(Gtk.StateFlags.NORMAL, {1.0, 0.1, 0.0, 0.4});
					this.save_button.set_tooltip_text("Save the current file (it is currently unsaved)");
				}
				else
				{
					this.save_button.override_background_color(Gtk.StateFlags.NORMAL, {0.0, 0.0, 0.0, 0.0});
					this.save_button.set_tooltip_text("Save the current file");
				}
			}
			else
			{
				this.root.consts.output("Source stack has a null tab currently");
			}
			
			this.root.consts.output("Updated filebar");
		}
	}
}
