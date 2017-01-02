tarball_scm = self

namespace :tarball do
  desc 'Create tarball'
  task :create do
    run_locally do
      tarball_scm.create
    end
  end

  desc 'Create and upload the tarball'
  task create_release: :'tarball:create' do
    on release_roles :all do
      tarball_scm.release
    end
  end

  task :set_current_revision do
    set :current_revision, tarball_scm.fetch_revision
  end
end
