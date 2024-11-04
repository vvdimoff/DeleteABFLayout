require 'sketchup.rb'

module DeleteABFLayout
  module Cleaner

    # Define the toolbar as a global variable
    @@toolbar = UI::Toolbar.new "ABF Layout Cleaner"

    # Function to delete all elements named "ABF_Flatten".
    def self.delete_abf_flatten
      model = Sketchup.active_model
      model.start_operation("Delete ABF_Flatten Layout")

      model.entities.each do |entity|
        if (entity.is_a?(Sketchup::ComponentInstance) || entity.is_a?(Sketchup::Group)) && entity.name == "ABF_Flatten"
          entity.erase!
        end
      end

      model.commit_operation
      # Set message in the status bar
      Sketchup.set_status_text("ABF_Flatten layout successfully deleted.")
    end

    # Function to find all groups named "ABF_Flatten".
    def self.find_abf_flatten_instances
      abf_flatten_instances = []
      Sketchup.active_model.entities.each do |entity|
        if entity.is_a?(Sketchup::Group) && entity.name == "ABF_Flatten"
          abf_flatten_instances << entity
        end
      end
      return abf_flatten_instances
    end

    # Main function to check and delete the layout
    def self.clean_layout
      if find_abf_flatten_instances.empty?
        # Show a message box if ABF_Flatten layout is not found
        UI.messagebox("ABF_Flatten layout not found.")
      else
        delete_abf_flatten
      end
    end

    unless file_loaded?(__FILE__)
      # Add the plugin to the menu
      menu = UI.menu('Plugins')
      menu.add_item('Delete ABF Layout') { self.clean_layout }

      # Add the plugin button to the toolbar
      cmd = UI::Command.new("Delete ABF Layout") { self.clean_layout }
      
      cmd.small_icon = File.join(File.dirname(__FILE__), "icons", "icon_small.png")
      cmd.large_icon = File.join(File.dirname(__FILE__), "icons", "icon_large.png")
      cmd.tooltip = "Delete ABF Layout"
      cmd.status_bar_text = "Delete ABF_Flatten layout from the model"
      
      @@toolbar.add_item cmd
      @@toolbar.show
      
      file_loaded(__FILE__)
    end

    # Method to remove the toolbar when the extension is unloaded
    def self.unload_extension
      @@toolbar.remove if defined?(@@toolbar)
    end

  end # module Cleaner
end # module DeleteABFLayout

# Register a callback to unload the toolbar when the extension is deactivated
if defined?(SketchupExtensions)
  extension = Sketchup.extensions["Delete ABF Layout"]
  extension.on_unload { DeleteABFLayout::Cleaner.unload_extension }
end
