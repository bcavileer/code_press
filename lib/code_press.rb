require 'code_press/version'
require 'code_press/source'
require 'code_press/destination'

module CodePress
  def self.procedure(src, dest)
    dest.src = src
    src.versions.each do |version|
      dest.version = version
      if dest.tagged?
        Logger.log "Repository already contains tag #{dest.tag_name}, skipping"
      else
        dest.update_repo
      end
      unless dest.tagged?

      end
    end
  end

  module Logger
    def self.log msg
      puts msg
    end
  end
end
