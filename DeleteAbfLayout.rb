require 'sketchup.rb'
require 'extensions.rb'

module DeleteABFLayout
  module Cleaner

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('Delete ABF Layout', 'DeleteABFLayout/main')
      ex.description = 'Delete ABF layout from SketchUp model.'
      ex.version     = '1.0.0'
      ex.copyright   = 'Ivanka.com.ua'
      ex.creator     = 'Meetda'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module Cleaner
end # module DeleteABFLayout

