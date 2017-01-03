require 'capistrano/scm/plugin'

module Capistrano
  module TarballScm
    class Plugin < Capistrano::SCM::Plugin
      def set_defaults
        set_if_empty :repo_url, '.'
        set_if_empty :repo_tree, '.'
        set_if_empty :tarball_dir, fetch(:tmp_dir)
        set_if_empty :tarball_exclude, []
      end

      def define_tasks
        eval_rakefile File.expand_path('../tasks/tarball.rake', __FILE__)
      end

      def register_hooks
        after 'deploy:new_release_path', 'tarball:create_release'
        before 'deploy:set_current_revision', 'tarball:set_current_revision'
      end

      def create
        excludes = fetch(:tarball_exclude).map { |d| "--exclude #{d}" }.join(' ')
        backend.execute(:mkdir, '-p', tarball_dir)
        backend.execute(:tar, '-C', tarball_root, '--exclude', tarball_dir, excludes, '-cjf', tarball_path, '.')
      end

      def release
        backend.execute(:mkdir, '-p', release_path)
        backend.upload!(tarball_path, release_path)

        backend.within(release_path) do
          backend.execute :tar, '-xjf', File.basename(tarball_path)
          backend.execute :rm, '-f', File.basename(tarball_path)
        end
      end

      def fetch_revision
        backend.capture(:git, 'rev-parse', 'HEAD').strip
      end

      private

      def tarball_dir
        fetch(:tarball_dir)
      end

      def tarball_name
        "#{release_timestamp}.tar.bz2"
      end

      def tarball_path
        File.join(tarball_dir, tarball_name)
      end

      def tarball_root
        File.join(fetch(:repo_url), fetch(:repo_tree))
      end
    end
  end
end
