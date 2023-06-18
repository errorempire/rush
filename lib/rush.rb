# frozen_string_literal: true

module RUSH
  class Shell
    def binary_exists?(binary)
      `which #{binary}`
      $?.success?
    end
  end

  class Git
    def self.git_info
      branch = `git branch --show-current 2> /dev/null`.chomp
      status = `git status --short 2> /dev/null`.chomp
      return unless branch && !branch.empty?

      info = "(#{branch})"
      info += ' *' unless status.empty?
      info
    end
  end

  class Commands
    def self.cd(path)
      path = Dir.home if path.nil? || path.empty?
      Dir.chdir(path)
    rescue SystemCallError => e
      puts "Error: #{e}"
    end
  end
end
