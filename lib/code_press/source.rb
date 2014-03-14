require 'open-uri'
require 'nokogiri'

module CodePress
  class Source
    def initialize(uri, tarball_regex, version_regex)
      @uri = uri
      @tarball_regex = tarball_regex
      @version_regex = version_regex
    end

    attr_reader :uri, :tarball_regex, :version_regex

    def versions
      tarballs.map &:version
    end

    def link_to_version(version)
      uri + tarballs.find {|tb| tb.version == version }
    end

    def tarballs
      href_links.map {|lnk| Tarball.new(lnk, version_regex) }.sort
    end

    def href_links
      Nokogiri.parse(index_page.read).
          css('a').
          select { |l| l.attributes['href'].value =~ tarball_regex }.
          map { |l| l.attributes['href'].value }
    end

    def index_page
      open(uri)
    end

    class Tarball
      def initialize(lnk, version_regex)
        @file = lnk
        @version = lnk.match(version_regex)[0]
      end

      attr_reader :version, :file

      def <=>(other)
        version <=> other.version
      end

      def to_str
        file
      end
    end
  end
end
