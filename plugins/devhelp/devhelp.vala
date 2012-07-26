// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/***
  BEGIN LICENSE
	
  Copyright (C) 2011-2012 Mario Guerriero <mefrio.g@gmail.com>
  This program is free software: you can redistribute it and/or modify it	
  under the terms of the GNU Lesser General Public License version 3, as published	
  by the Free Software Foundation.
	
  This program is distributed in the hope that it will be useful, but	
  WITHOUT ANY WARRANTY; without even the implied warranties of	
  MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR	
  PURPOSE.  See the GNU General Public License for more details.
	
  You should have received a copy of the GNU General Public License along	
  with this program.  If not, see <http://www.gnu.org/licenses/>	
  
  END LICENSE	
***/

public class Scratch.Plugins.DevHelp : Peas.ExtensionBase,  Peas.Activatable
{
    Interface plugins;
    public Object object { owned get; construct; }
   
    public void update_state () {
    }

    public void activate () {
        plugins = (Scratch.Plugins.Interface)object;        
        plugins.register_function(Interface.Hook.BOTTOMBAR, on_bottombar);
    }

    public void deactivate () {

    }
    
    void on_bottombar () {
        if (plugins.bottombar != null && plugins.scratch_app != null) {
            
            var dhbase = new Dh.Base ();
            
            var window = dhbase.get_window ();

            var widget = ((Gtk.Bin)window).get_child ();
            
            ((Gtk.Container)window).remove (widget);
            window.destroy ();    
            plugins.bottombar.append_page (widget, new Gtk.Label ("Devhelp"));
        }
    }
}

[ModuleInit]
public void peas_register_types (GLib.TypeModule module) {
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type (typeof (Peas.Activatable),
                                     typeof (Scratch.Plugins.DevHelp));
}