require 'git'
require 'open3'

module CodePress
  class Destination
    def initialize(repo)
      @repo = repo
      @git = Git.open(repo)
      log "Repository set to #{repo}"
    end

    def src=(src)
      @src = src
      log "Source set to #{src.uri}"
    end

    def version=(version)
      @version = version
      log "Version set to #{version}"
    end

    attr_reader :repo, :git, :src, :version

    def update_repo
      uri = src.link_to_version(version)
      r = nil
      git.with_temp_working do
        Tempfile.create('archive') do |f|
          log "Downloading #{uri} to #{f.path}"
          f.print open(uri).read
          log "Extracting #{f.path} to #{Dir.pwd}"
          system "tar -xzf #{f.path} --strip-components=1"
          log "Extracted #{f.path}"
        end

        git.add

        log "Changed #{git.status.changed.size} files\n"
        log "Added #{git.status.added.size} files\n"
        log "Deleted #{git.status.deleted.size} files\n"
        log "#{git.status.untracked.size} files untracked\n"

        git.commit_all(commit_message)
        log "Commited #{commit_message}"
      end

      log "Cleaning up"
      git.reset_hard
      git.clean :force => true, :d => true

      git.add_tag tag_name
      log "Tagged #{tag_name}"
    end

    def tag_name
      "v#{version}"
    end

    def commit_message
      "Version #{version}"
    end

    def tagged?
      git.tags.map(&:name).include? tag_name
    end

    def log(msg)
      Logger.log msg
    end
  end
end
