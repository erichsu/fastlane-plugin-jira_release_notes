module Fastlane
  module Helper
    class JiraReleaseNotesHelper
      # class methods that you define here become available in your action
      # as `Helper::JiraReleaseNotesHelper.your_method`

      def self.plain_format(issues)
        issues
          .group_by { |i| i.issuetype.name }
          .map { |k, v| 
            titles = v.map { |i| "[#{i.key}] - #{i.summary}" }.join("\n")
            "#{k}:\n#{titles}"
          }
          .join("\n")
      end

      def self.html_format(issues, url)
        require "cgi"
        issues.map do |i|
          summary = CGI.escapeHTML(i.summary)
          "[<a href='#{url}/browse/#{i.key}'>#{i.key}</a>] - #{summary}"
        end.join("\n")
      end
    end
  end
end
